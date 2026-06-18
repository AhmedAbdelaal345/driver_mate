import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class ServiceCenterModel {
  final String name;
  final GeoPoint location;
  final double distance;
  final String address;
  final String phone;
  final List<String> services;
  final String workingHours;
  final String imagePath;
  const ServiceCenterModel({
    required this.name,
    required this.location,
    required this.distance,
    required this.address,
    required this.phone,
    required this.services,
    required this.workingHours,
    required this.imagePath,
  });
}
