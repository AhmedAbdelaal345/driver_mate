import 'dart:io';

import 'package:driver_mate/core/local/api_keys.dart';


enum VehicleStatus { active, inService, inactive }

class VechicleModel {
  final String id;
  final String userId;
  final int brandId;
  final int modelId;
  final String brandName;
  final String modelName;
  final int year;
  final String plateNumber;
  final int currentMileage;
  VehicleStatus status;
  File? image;

  VechicleModel({
    required this.id,
    required this.userId,
    required this.brandId,
    required this.modelId,
    required this.brandName,
    required this.modelName,
    required this.year,
    required this.plateNumber,
    required this.currentMileage,
    required this.status,
    this.image,
  });
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.userId: userId,
      ApiKeys.brandId: brandId,
      ApiKeys.modelId: modelId,
      ApiKeys.brandName: brandName,
      ApiKeys.modelName: modelName,
      ApiKeys.year: year,
      ApiKeys.plateNumber: plateNumber,
      ApiKeys.currentMileage: currentMileage,
    };
  }

  factory VechicleModel.fromJson(Map<String, dynamic> json) {
    return VechicleModel(
      id: json[ApiKeys.id],
      userId: json[ApiKeys.userId],

      brandId: json[ApiKeys.brandId],
      brandName: json[ApiKeys.brandName],
      modelId: json[ApiKeys.modelId],
      modelName: json[ApiKeys.modelName],
      year: json[ApiKeys.year],
      image: json[ApiKeys.image] != null ? File(json[ApiKeys.image]) : null,
      plateNumber: json[ApiKeys.plateNumber],
      currentMileage: json[ApiKeys.currentMileage],
      
      status: VehicleStatus.values.firstWhere(
        (s) => s.name == json["status"],
        orElse: () => VehicleStatus.inactive,
      ),
    );
  }
}
