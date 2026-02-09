import 'package:driver_mate/feature/booking/data/model/maintenance_center_model.dart';
import 'package:geolocator/geolocator.dart';

class MaintenanceRepo {
  // Dummy data for maintenance centers (configured around Cairo for demo)
  final List<MaintenanceCenter> _centers = [
    MaintenanceCenter(
      name: 'AutoCare Service Center',
      address: 'Downtown, Cairo',
      latitude: 30.0444,
      longitude: 31.2357,
      rating: 4.8,
      imagePath: 'assets/images/service_center_1.jpg', // Placeholder
      isRecommended: true,
    ),
    MaintenanceCenter(
      name: 'QuickFix Auto',
      address: 'Nasr City, Cairo',
      latitude: 30.0566,
      longitude: 31.3301,
      rating: 4.5,
      imagePath: 'assets/images/service_center_2.jpg',
    ),
    MaintenanceCenter(
      name: 'ProMechanic Hub',
      address: 'Maadi, Cairo',
      latitude: 29.9602,
      longitude: 31.2569,
      rating: 4.9,
      imagePath: 'assets/images/service_center_3.jpg',
    ),
    MaintenanceCenter(
      name: 'City Garage',
      address: 'Heliopolis, Cairo',
      latitude: 30.0898,
      longitude: 31.3283,
      rating: 4.2,
      imagePath: 'assets/images/service_center_4.jpg',
    ),
    MaintenanceCenter(
      name: 'Express Oil Change',
      address: 'Zamalek, Cairo',
      latitude: 30.0609,
      longitude: 31.2197,
      rating: 4.6,
      imagePath: 'assets/images/service_center_5.jpg',
    ),
  ];

  // Simulated user location (e.g., somewhere in Dokki)
  // latitude: 30.0385, longitude: 31.2125
  final double userLat = 30.0385;
  final double userLng = 31.2125;

  Future<List<MaintenanceCenter>> getSortedCenters() async {
    // Calculate distance for each center
    for (var center in _centers) {
      double distanceInMeters = Geolocator.distanceBetween(
        userLat,
        userLng,
        center.latitude,
        center.longitude,
      );
      // Convert to km
      center.distance = distanceInMeters / 1000;
    }

    // Sort by distance
    _centers.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    return _centers;
  }
}
