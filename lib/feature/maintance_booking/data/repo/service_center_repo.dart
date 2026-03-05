import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';

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
        serviceCenterName: 'BMW Service Center',
        imagePath: AppImagePath.bmwCarImagePath,
        address: '123 Main St, City, Country',
        workingHours: 'Mon-Fri: 8am - 6pm',
        phoneNumber: '+1234567890',
        holiday: 'Sunday',
        distance: "2.5",
        servicesOffered: [
          'Oil Change',
          'Tire Rotation',
          'Brake Inspection',
          'Battery Check',
        ],
      ),
      ServiceCenterModel(
        serviceCenterName: 'Audi Service Center',
        imagePath: AppImagePath.camryCarImagePath,
        address: '456 Elm St, City, Country',
        workingHours: 'Mon-Fri: 9am - 5pm',
        phoneNumber: '+0987654321',
        holiday: 'Saturday',
        distance: "3.0",
        servicesOffered: [
          'Engine Diagnostics',
          'Transmission Repair',
          'Wheel Alignment',
          'Air Conditioning Service',
        ],
      ),
    ];
  }
}
