import 'package:driver_mate/feature/car_details/data/model/car_details_model.dart';

abstract class CarDetailsState {}

class CarDetailsInitial extends CarDetailsState {}

class CarDetailsLoading extends CarDetailsState {}

class CarDetailsLoaded extends CarDetailsState {
  final List<CarDetailsModel> carDetails;

  CarDetailsLoaded(this.carDetails);
}

class CarDetailsError extends CarDetailsState {
  final String message;

  CarDetailsError(this.message);
}
