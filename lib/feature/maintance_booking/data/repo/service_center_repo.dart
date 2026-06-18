import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class ServiceCenterRepo {
  ServiceCenterRepo._privateConstructor();
  static final ServiceCenterRepo instance =
      ServiceCenterRepo._privateConstructor();
  factory ServiceCenterRepo() {
    return instance;
  }
  Future<List<ServiceCenterModel>> getServiceCenterData() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      ServiceCenterModel(
        name: 'Audi Service Center',
        imagePath: AppImagePath.camryCarImagePath,
        address: '456 Elm St, City, Country',
        workingHours: 'Mon-Fri: 9am - 5pm',
        phone: '+0987654321',
        location: GeoPoint(latitude: 0, longitude: 200),
        distance: 3.0,
        services: [
          'Engine Diagnostics',
          'Transmission Repair',
          'Wheel Alignment',
          'Air Conditioning Service',
        ],
      ),
      ServiceCenterModel(
        name: 'Audi Service Center',
        imagePath: AppImagePath.camryCarImagePath,
        address: '456 Elm St, City, Country',
        workingHours: 'Mon-Fri: 9am - 5pm',
        phone: '+0987654321',
        location: GeoPoint(latitude: 0, longitude: 200),
        distance: 3.0,
        services: [
          'Engine Diagnostics',
          'Transmission Repair',
          'Wheel Alignment',
          'Air Conditioning Service',
        ],
      ),
    ];
  }
}
