import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';

class VechicleRepo {
  VechicleRepo._internal();
  static final VechicleRepo _instance = VechicleRepo._internal();
  factory VechicleRepo() => _instance;

  static const String _carsKey = 'cars_list';

  /// Get vehicles: tries API first, falls back to cache
  Future<Either<String, List<VechicleModel>>> getVehicles() async {
  try {
    final response = await ApiHelper().getRequest(
      endpoint: "Vehicles/my",
      isAuthorized: true,
      isForm: false,
      queryParameters: {
        "pageNumber":1,
        "pageSize":10
      }
    );

    // Debug: see what the server actually sent
    debugPrint("\n\n \n getVehicles status: ${response.statusCode} \n\n \n ");
    debugPrint("\n\n \n getVehicles data type: ${response.data.runtimeType} \n\n \n ");
    debugPrint("\n\n \n getVehicles data: ${response.data} \n\n \n ");

    if (response.statusCode == 200 && response.data != null) {
      final List<dynamic> rawList;

      if (response.data is List) {
        rawList = response.data as List<dynamic>;
      } else if (response.data is Map<String, dynamic>) {
        // If ApiResponse returned the whole map instead of extracting data
        final map = response.data as Map<String, dynamic>;
        if (map['data'] is List) {
          rawList = map['data'] as List<dynamic>;
        } else {
          return Left("Unexpected response: 'data' is not a list");
        }
      } else {
        return Left("Unexpected response type: ${response.data.runtimeType}");
      }

      final vehicles = rawList.map((e) => VechicleModel.fromJson(e)).toList();
      await _saveToCache(vehicles);
      return Right(vehicles);
    }

    // If status is not 200, return the message from ApiResponse
    return Left(response.message);
  } on SocketException {
    final cached = await _getFromCache();
    return Right(cached);
  } catch (e) {
    log(e.toString());
    return Left(e.toString());
  }
}
  Future<Either<String, String>> addCar({required VechicleModel car}) async {
    try {
      final response = await ApiHelper().postRequest(
        endpoint: "Vehicles",
        isAuthorized: true,
        isForm: false,
        data: car.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response.message);
      }
      return Left(response.message);
    } on SocketException {
      // Save locally for later sync
      final cached = await _getFromCache();
      cached.add(car);
      await _saveToCache(cached);
      return Right("Saved locally. Will sync when online.");
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
      final response = await ApiHelper().putRequest(
        endpoint: "Vehicles/${newCar.id}",
        isAuthorized: true,
        isForm: false,
        data: newCar.toJson(),
      );
      if (response.statusCode != 200) {
        return Left(response.message);
      }
      return Right(response.message);
    } on SocketException {
      final cached = await _getFromCache();

      final updated = cached.map((existing) {
        // Compare by ID, not brand/model/year
        if (existing.id == oldCar.id) return newCar;
        return existing;
      }).toList();

      await _saveToCache(updated);
      return Right("Updated locally. Will sync when online.");
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteCar({required VechicleModel car}) async {
    try {
      final response = await ApiHelper().deleteRequest(
        endpoint: "Vehicles/${car.id}",
        isAuthorized: true,
        isForm: false,
      );
      if (response.statusCode != 200) {
        return Left(response.message);
      }
      return Right(response.message);
    } on SocketException {
      final cached = await _getFromCache();

      // Remove by ID
      final updated = cached.where((v) => v.id != car.id).toList();

      await _saveToCache(updated);
      return Right("Deleted locally. Will sync when online.");
    } catch (e) {
      log(e.toString());
      return Left(e.toString());
    }
  }

  // ─── Cache Helpers ───

  Future<List<VechicleModel>> _getFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = prefs.getStringList(_carsKey) ?? [];
    return carsJson
        .map((json) => VechicleModel.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> _saveToCache(List<VechicleModel> vehicles) async {
    final prefs = await SharedPreferences.getInstance();
    final carsJson = vehicles.map((v) => jsonEncode(v.toJson())).toList();
    await prefs.setStringList(_carsKey, carsJson);
  }
}
