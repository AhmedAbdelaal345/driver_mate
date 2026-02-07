class VechicleModel {
  String? brand;
  String? model;
  int? year;
  String? plateNumber;
  double? millAge;
  DateTime? date;
  VechicleModel({
    this.brand,
    this.model,
    this.year,
    this.plateNumber,
    this.millAge,
    this.date,
  });
  Map<String, dynamic> toJson() {
    return {
      "brand": brand,
      "model": model,
      "year": year,
      "plateNumber": plateNumber,
      "millAge": millAge,
      "date": date?.toIso8601String(),
    };
  }

  factory VechicleModel.fromJson(Map<String, dynamic> json) {
    return VechicleModel(
      brand: json["brand"],
      model: json["model"],
      year: json["year"],
      plateNumber: json["plateNumber"],
      millAge: json["millAge"],
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    );
  }
}
