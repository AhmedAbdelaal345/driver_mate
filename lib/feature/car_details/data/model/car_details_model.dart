class CarDetailsModel {
  final String carName;
  final String carYear;
  final String carType;
  final String price;
  final String carDescription;
  final String carImagePath;
  final bool isNew;

  const CarDetailsModel({
    required this.carName,
    required this.carYear,
    required this.carType,
    required this.carDescription,
    required this.carImagePath,
    this.price = "0",
    this.isNew = false,
  });
  factory CarDetailsModel.fromJson(Map<String, dynamic> json) {
    return CarDetailsModel(
      carName: json['carName'] as String,
      carYear: json['carYear'] as String,
      carType: json['carType'] as String,
      carDescription: json['carDescription'] as String,
      carImagePath: json['carImagePath'] as String,
      isNew: json['isNew'] as bool? ?? false,
      price: json['price'] as String? ?? "0",
    );
  }
}
