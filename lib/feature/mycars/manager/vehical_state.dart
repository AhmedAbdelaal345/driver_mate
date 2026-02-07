import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';

class VehicalState {}

class InitialVehicalState extends VehicalState {}

class LoadingVehicalState extends VehicalState {}

class SuccessVehicalState extends VehicalState {
  final String message;
  final List<VechicleModel> data;
  SuccessVehicalState({required this.data, required this.message});
}

class AddVehicalSuccessState extends VehicalState {
  final String message;
  final VechicleModel vehicle;
  AddVehicalSuccessState({required this.vehicle, required this.message});
}

class ErrorVehicalState extends VehicalState {
  final String error;
  ErrorVehicalState({required this.error});
}
