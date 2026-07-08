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
      "status": status.name,
      "image": image?.path,
    };
  }

  factory VechicleModel.fromJson(Map<String, dynamic> json) {
    return VechicleModel(
      id: json[ApiKeys.id]?.toString() ?? "",
      userId: json[ApiKeys.userId]?.toString() ?? "",
      brandId: json[ApiKeys.brandId] is int ? json[ApiKeys.brandId] : int.tryParse(json[ApiKeys.brandId]?.toString() ?? "") ?? 0,
      brandName: json[ApiKeys.brandName]?.toString() ?? "",
      modelId: json[ApiKeys.modelId] is int ? json[ApiKeys.modelId] : int.tryParse(json[ApiKeys.modelId]?.toString() ?? "") ?? 0,
      modelName: json[ApiKeys.modelName]?.toString() ?? "",
      year: json[ApiKeys.year] is int ? json[ApiKeys.year] : int.tryParse(json[ApiKeys.year]?.toString() ?? "") ?? 0,
      image: json["image"] != null ? File(json["image"]) : (json[ApiKeys.image] != null ? File(json[ApiKeys.image]) : null),
      plateNumber: json[ApiKeys.plateNumber]?.toString() ?? "",
      currentMileage: json[ApiKeys.currentMileage] is int ? json[ApiKeys.currentMileage] : (double.tryParse(json[ApiKeys.currentMileage]?.toString() ?? "")?.toInt() ?? 0),
      status: VehicleStatus.values.firstWhere(
        (s) => s.name == json["status"],
        orElse: () => VehicleStatus.inactive,
      ),
    );
  }

  VechicleModel copyWith({
    String? id,
    String? userId,
    int? brandId,
    int? modelId,
    String? brandName,
    String? modelName,
    int? year,
    String? plateNumber,
    int? currentMileage,
    VehicleStatus? status,
    File? image,
  }) {
    return VechicleModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      brandId: brandId ?? this.brandId,
      modelId: modelId ?? this.modelId,
      brandName: brandName ?? this.brandName,
      modelName: modelName ?? this.modelName,
      year: year ?? this.year,
      plateNumber: plateNumber ?? this.plateNumber,
      currentMileage: currentMileage ?? this.currentMileage,
      status: status ?? this.status,
      image: image ?? this.image,
    );
  }
}
