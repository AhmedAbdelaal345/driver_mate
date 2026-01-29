import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';

/// ✅ Mock Data (Cars)
const List<CarItem> mockCars = [
  CarItem(
    image: AppImagePath.camryCarImagePath,
    title: "Toyota Camry 2021",
    price: 28000,
    location: "Downtown Dubai",
    category: "Cars",
  ),
  CarItem(
    image: AppImagePath.bmwCarImagePath,
    title: "BMW 320i 2020",
    price: 35000,
    location: "Business Bay",
    category: "Cars",
  ),
  CarItem(
    image: AppImagePath.carImagePath,
    title: "Tesla Model 3 2022",
    price: 42000,
    location: "Dubai Marina",
    category: "Cars",
  ),
];

/// ✅ Mock Data (Service Centers)
const List<ServiceCenterItem> mockServices = [
  ServiceCenterItem(
    image: "assets/images/service_center.png",
    name: "AutoCare Service Center",
    distanceKm: 2.3,
    rating: 4.8,
  ),
  ServiceCenterItem(
    image: "assets/images/service_center.png",
    name: "QuickFix Auto Center",
    distanceKm: 6.0,
    rating: 4.4,
  ),
  ServiceCenterItem(
    image: "assets/images/service_center.png",
    name: "Premium Auto Service",
    distanceKm: 12.0,
    rating: 4.9,
  ),
];
