import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/local/shared_key.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VechicleRepo {
  VechicleRepo._singleTone();
  static final instance = VechicleRepo._singleTone();
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

    final List<String> carsJson =
        prefs.getStringList(SharedKey.carsList) ?? [];

    return carsJson
        .map((e) => VechicleModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
