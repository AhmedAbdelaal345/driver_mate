import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';

class VechicleRepo {
  VechicleRepo._internal();
  static final VechicleRepo _instance = VechicleRepo._internal();
  factory VechicleRepo() => _instance;

  static const String _carsCacheKey = 'cars_cache_list';
  static const String _carImagesKey = 'car_images_map';
  static const String _carStatusKey = 'car_status_map';

  String _getCarKey(VechicleModel car) {
    if (car.id != "0" && car.id.isNotEmpty) return car.id;
    return '${car.brandName}_${car.modelName}_${car.year}_${car.plateNumber}';
  }

  Future<void> _saveCarLocals(VechicleModel car) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getCarKey(car);
    
    if (car.image != null) {
      final imagesJson = prefs.getString(_carImagesKey) ?? '{}';
      final Map<String, dynamic> imagesMap = jsonDecode(imagesJson);
      imagesMap[key] = car.image!.path;
      await prefs.setString(_carImagesKey, jsonEncode(imagesMap));
    }
    
    final statusJson = prefs.getString(_carStatusKey) ?? '{}';
    final Map<String, dynamic> statusMap = jsonDecode(statusJson);
    statusMap[key] = car.status.name;
    await prefs.setString(_carStatusKey, jsonEncode(statusMap));
  }

  Future<void> _deleteCarLocals(VechicleModel car) async {
    final prefs = await SharedPreferences.getInstance();
    
    final imagesJson = prefs.getString(_carImagesKey) ?? '{}';
    final Map<String, dynamic> imagesMap = jsonDecode(imagesJson);
    imagesMap.remove(car.id);
    imagesMap.remove('${car.brandName}_${car.modelName}_${car.year}_${car.plateNumber}');
    await prefs.setString(_carImagesKey, jsonEncode(imagesMap));
    
    final statusJson = prefs.getString(_carStatusKey) ?? '{}';
    final Map<String, dynamic> statusMap = jsonDecode(statusJson);
    statusMap.remove(car.id);
    statusMap.remove('${car.brandName}_${car.modelName}_${car.year}_${car.plateNumber}');
    await prefs.setString(_carStatusKey, jsonEncode(statusMap));
  }

  Future<void> _populateLocals(List<VechicleModel> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final imagesJson = prefs.getString(_carImagesKey) ?? '{}';
    final Map<String, dynamic> imagesMap = jsonDecode(imagesJson);
    
    final statusJson = prefs.getString(_carStatusKey) ?? '{}';
    final Map<String, dynamic> statusMap = jsonDecode(statusJson);
    
    bool needsSave = false;

    for (var vehicle in vehicles) {
      var key = vehicle.id;
      
      // Auto-migrate name-based key to database ID key when we first load it
      if (!imagesMap.containsKey(vehicle.id) && !statusMap.containsKey(vehicle.id)) {
        final fallbackKey = '${vehicle.brandName}_${vehicle.modelName}_${vehicle.year}_${vehicle.plateNumber}';
        if (imagesMap.containsKey(fallbackKey) || statusMap.containsKey(fallbackKey)) {
          if (imagesMap.containsKey(fallbackKey)) {
            imagesMap[vehicle.id] = imagesMap[fallbackKey];
          }
          if (statusMap.containsKey(fallbackKey)) {
            statusMap[vehicle.id] = statusMap[fallbackKey];
          }
          needsSave = true;
        } else {
          key = fallbackKey;
        }
      }

      if (imagesMap.containsKey(key)) {
        vehicle.image = File(imagesMap[key]);
      }
      if (statusMap.containsKey(key)) {
        vehicle.status = VehicleStatus.values.firstWhere(
          (s) => s.name == statusMap[key],
          orElse: () => VehicleStatus.inactive,
        );
      }
    }

    if (needsSave) {
      await prefs.setString(_carImagesKey, jsonEncode(imagesMap));
      await prefs.setString(_carStatusKey, jsonEncode(statusMap));
    }
  }

  // ─── Remote & Local Hybrid Operations ───

  Future<Either<String, List<VechicleModel>>> getVehicles() async {
    try {
      final response = await ApiHelper().getRequest(
        endpoint: "Vehicles/my",
        isAuthorized: true,
        isForm: false,
        queryParameters: {
          "pageNumber": 1,
          "pageSize": 10
        }
      );

      if ((response.statusCode == 200 || response.statusCode == 201) && response.data != null) {
        final List<dynamic> rawList;

        if (response.data is List) {
          rawList = response.data as List<dynamic>;
        } else if (response.data is Map<String, dynamic>) {
          final map = response.data as Map<String, dynamic>;
          if (map['data'] is List) {
            rawList = map['data'] as List<dynamic>;
          } else {
            return const Left("Unexpected response: 'data' is not a list");
          }
        } else {
          return Left("Unexpected response type: ${response.data.runtimeType}");
        }

        final vehicles = rawList.map((e) => VechicleModel.fromJson(e)).toList().reversed.toList();
        await _populateLocals(vehicles);
        await _saveToCache(vehicles);
        return Right(vehicles);
      }
      
      // If server returned non-200 but we have local cache, load it
      final cached = await _getFromCache();
      if (cached.isNotEmpty) return Right(cached);
      return Left(response.message);
    } catch (e) {
      log(e.toString());
      final cached = await _getFromCache();
      if (cached.isNotEmpty) return Right(cached);
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> addCar({required VechicleModel car}) async {
    try {
      // 1. Save status and image locally using fallback key
      await _saveCarLocals(car);

      // 2. Call backend API to persist the details
      final response = await ApiHelper().postRequest(
        endpoint: "Vehicles",
        isAuthorized: true,
        isForm: false,
        data: car.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Add to cache list
        final cached = await _getFromCache();
        cached.insert(0, car); // Insert at the beginning so it's first
        await _saveToCache(cached);
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> updateCar({
    required VechicleModel oldCar,
    required VechicleModel newCar,
  }) async {
    try {
      // 1. Save updated status and image locally
      await _saveCarLocals(newCar);

      // 2. Update cache list
      final cached = await _getFromCache();
      final updated = cached.map((v) => v.id == oldCar.id ? newCar : v).toList();
      await _saveToCache(updated);

      // 3. Update remote database details
      final response = await ApiHelper().putRequest(
        endpoint: "Vehicles/${newCar.id}",
        isAuthorized: true,
        isForm: false,
        data: newCar.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteCar({required VechicleModel car}) async {
    try {
      // 1. Delete status and image locally
      await _deleteCarLocals(car);

      // 2. Remove from cached list
      final cached = await _getFromCache();
      cached.removeWhere((v) => v.id == car.id);
      await _saveToCache(cached);

      // 3. Delete remote database entry
      final response = await ApiHelper().deleteRequest(
        endpoint: "Vehicles/${car.id}",
        isAuthorized: true,
        isForm: false,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  // ─── Cache Helpers ───

  Future<List<VechicleModel>> _getFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = prefs.getStringList(_carsCacheKey) ?? [];
    return carsJson
        .map((json) => VechicleModel.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> _saveToCache(List<VechicleModel> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = vehicles.map((v) => jsonEncode(v.toJson())).toList();
    await prefs.setStringList(_carsCacheKey, carsJson);
  }
}
