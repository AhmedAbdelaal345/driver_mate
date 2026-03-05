import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/car_details/data/model/car_details_model.dart';

class CarDetailsRepo {
  CarDetailsRepo._privateConstructor();
  static final CarDetailsRepo _instance = CarDetailsRepo._privateConstructor();
  factory CarDetailsRepo() {
    return _instance;
  }
  List<CarDetailsModel> getDetailsCars() {
    return [
      CarDetailsModel(
        carName: 'Toyota Camry',
        carYear: '2020',
        carType: 'Sedan',
        carDescription:
            'The Toyota Camry is a midsize sedan known for its reliability, comfort, and fuel efficiency. It offers a smooth ride, spacious interior, and advanced safety features, making it a popular choice for families and commuters alike.',
        carImagePath: AppImagePath.camryCarImagePath,
        price: '\$24,000',
      ),
      CarDetailsModel(
        carName: 'Honda Accord',
        carYear: '2019',
        carType: 'Sedan',
        carDescription:
            'The Honda Accord is a midsize sedan that combines style, performance, and practicality. It features a comfortable interior, responsive handling, and a range of advanced technology options, making it a favorite among drivers seeking a well-rounded vehicle.',
        carImagePath: AppImagePath.carImagePath,
        price: '\$22,500',
      ),
      CarDetailsModel(
        carName: 'Ford Mustang',
        carYear: '2021',
        carType: 'Sports Car',
        carDescription:
            'The Ford Mustang is an iconic sports car that delivers thrilling performance and aggressive styling. With powerful engine options and sharp handling, the Mustang offers an exhilarating driving experience for enthusiasts who crave speed and excitement.',
        carImagePath: AppImagePath.bmwCarImagePath,
        price: '\$28,000',
      ),
    ];
  }
}
