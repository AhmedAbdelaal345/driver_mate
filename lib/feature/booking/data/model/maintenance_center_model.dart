class MaintenanceCenter {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double rating;
  final String imagePath;
  final bool isRecommended;
  double? distance; // Distance from user in km or meters

  MaintenanceCenter({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.imagePath,
    this.isRecommended = false,
    this.distance,
  });
}
