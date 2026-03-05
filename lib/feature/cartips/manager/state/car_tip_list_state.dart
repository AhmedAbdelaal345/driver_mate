import 'package:driver_mate/feature/cartips/data/model/car_tip_list_model.dart';

abstract class CarTipState {}

class CarTipInitial extends CarTipState {}

class CarTipLoading extends CarTipState {}

class CarTipLoaded extends CarTipState {
  final List<CarTipListModel> tip;

  CarTipLoaded(this.tip);
}

class CarTipError extends CarTipState {
  final String message;

  CarTipError(this.message);
}
