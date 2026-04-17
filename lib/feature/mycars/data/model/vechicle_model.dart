import 'dart:io';

enum VehicleStatus { active, inService, inactive }

class VechicleModel {
  String brand;
  String model;
  int year;
  String plateNumber;
  File? image;
  double millAge;
  DateTime date;
  VehicleStatus status;

  VechicleModel({
    required this.brand,
    required this.model,
    required this.year,
    required this.plateNumber,
    required this.millAge,
    required this.date,
    required this.status,
    this.image,
  });
  Map<String, dynamic> toJson() {
    return {
      "brand": brand,
      "model": model,
      "year": year,
      "plateNumber": plateNumber,
      "millAge": millAge,
      "image": image?.path,
      "status": status.name,
      "date": date.toIso8601String(),
    };
  }

  factory VechicleModel.fromJson(Map<String, dynamic> json) {
    return VechicleModel(
      brand: json["brand"],
      model: json["model"],
      year: json["year"],
      image: json["image"] != null ? File(json["image"]) : null,
      plateNumber: json["plateNumber"],
      millAge: json["millAge"],
      date: json["date"] != null
          ? DateTime.parse(json["date"])
          : DateTime.now(),
      status: VehicleStatus.values.firstWhere(
        (s) => s.name == json["status"],
        orElse: () => VehicleStatus.inactive,
      ),
    );
  }
}
