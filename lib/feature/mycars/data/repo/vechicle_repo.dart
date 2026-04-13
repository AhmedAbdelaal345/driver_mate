import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/local/shared_key.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VechicleRepo {
  VechicleRepo._singleTone();
  static final VechicleRepo instance = VechicleRepo._singleTone();
  factory VechicleRepo() => instance;

  /// add car
  Future<Either<String, VechicleModel>> addCar({
    required VechicleModel car,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      /// get old list
      final List<String> carsJson =
          prefs.getStringList(SharedKey.carsList) ?? [];

      /// convert new car to json
      final carMap = jsonEncode(car.toJson());

      carsJson.add(carMap);

      /// save list
      await prefs.setStringList(SharedKey.carsList, carsJson);

      return Right(car);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  /// load all cars 🔥
  Future<List<VechicleModel>> getCar() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> carsJson = prefs.getStringList(SharedKey.carsList) ?? [];

    return carsJson.map((e) => VechicleModel.fromJson(jsonDecode(e))).toList();
  }

  /// update car
  Future<Either<String, VechicleModel>> updateCar({
    required VechicleModel oldCar,
    required VechicleModel newCar,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      /// get current list
      final List<String> carsJson =
          prefs.getStringList(SharedKey.carsList) ?? [];

      final List<String> updatedList = carsJson.map((carJson) {
        final existingCar = VechicleModel.fromJson(jsonDecode(carJson));

        /// لو دي العربية القديمة استبدلها بالجديدة
        if (existingCar.brand == oldCar.brand &&
            existingCar.model == oldCar.model &&
            existingCar.year == oldCar.year &&
            existingCar.plateNumber == oldCar.plateNumber) {
          return jsonEncode(newCar.toJson());
        }

        return carJson;
      }).toList();

      /// save updated list
      await prefs.setStringList(SharedKey.carsList, updatedList);

      return Right(newCar);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteCar({required VechicleModel car}) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      /// Get current list
      final List<String> carsJson =
          prefs.getStringList(SharedKey.carsList) ?? [];

      /// Find and remove the car
      final updatedList = carsJson.where((carJson) {
        final existingCar = VechicleModel.fromJson(jsonDecode(carJson));
        // Compare by brand, model, and year
        return !(existingCar.brand == car.brand &&
            existingCar.model == car.model &&
            existingCar.year == car.year);
      }).toList();

      /// Save updated list
      await prefs.setStringList(SharedKey.carsList, updatedList);

      return const Right(true);
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }
}
