import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';

const List<CarItem> mockCars = [
  CarItem(
    image: AppImagePath.camryCarImagePath,
    title: 'Toyota Camry 2021',
    price: 28000,
    location: 'Downtown Dubai',
    category: 'Cars',
    subtitle: 'Luxury Sedan',
    details: 'Comfort · Reliability',
    isNew: true,
  ),
  CarItem(
    image: AppImagePath.bmwCarImagePath,
    title: 'BMW X5 2024',
    price: 35000,
    location: 'Business Bay',
    category: 'Cars',
    subtitle: 'Luxury SUV',
    details: 'Performance · Spacious',
    isNew: true,
  ),
  CarItem(
    image: AppImagePath.carImagePath,
    title: 'Mercedes-Benz C-Class',
    price: 42000,
    location: 'Dubai Marina',
    category: 'Cars',
    subtitle: 'Luxury Sedan',
    details: 'Premium · Comfort',
  ),
];

const List<ServiceCenterItem> mockServices = [
  ServiceCenterItem(
    name: 'AutoCare Service Center',
    distanceKm: 2.3,
    rating: 4.8,
  ),
  ServiceCenterItem(
    name: 'QuickFix Auto Repair',
    distanceKm: 3.1,
    rating: 4.6,
  ),
  ServiceCenterItem(
    name: 'Premium Motor Services',
    distanceKm: 1.8,
    rating: 4.9,
  ),
];

const List<TipItem> mockTips = [
  TipItem(
    image: AppImagePath.tairImagePath,
    category: 'Maintenance',
    readTime: '5 min read',
    title: '10 Essential Car Maintenance Tips',
    excerpt: 'Simple checks and habits that keep your vehicle reliable and safe.',
  ),
  TipItem(
    image: AppImagePath.newsImagePath,
    category: 'Tips',
    readTime: '4 min read',
    title: 'How to prepare your car for long road trips',
    excerpt: 'A quick checklist to reduce breakdowns before you hit the road.',
  ),
];
