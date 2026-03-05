class ServiceCenterModel {
  final String? serviceCenterName;
  final String? imagePath;
  final String? address;
  final String? workingHours;
  final String? phoneNumber;
  final String? holiday;
  final String? distance;
  final double? price;
  final List<String>? servicesOffered;
  ServiceCenterModel({
    this.serviceCenterName,
    this.imagePath,
    this.address,
    this.workingHours,
    this.phoneNumber,
    this.holiday,
    this.distance,
    this.price,
    this.servicesOffered,
  });
  factory ServiceCenterModel.fromJson(Map<String, dynamic> json) {
    return ServiceCenterModel(
      serviceCenterName: json['serviceCenterName'] as String?,
      imagePath: json['imagePath'] as String?,
      address: json['address'] as String?,
      workingHours: json['workingHours'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      price: json["price"],
      holiday: json['holiday'] as String?,
      distance: json['distance'] as String?,
      servicesOffered: (json['servicesOffered'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
