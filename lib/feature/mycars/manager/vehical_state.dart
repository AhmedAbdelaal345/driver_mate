import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';

class VehicalState {}

class InitialVehicalState extends VehicalState {}

class LoadingVehicalState extends VehicalState {}

class SuccessVehicalState extends VehicalState {
  final String message;
  final List<VechicleModel> data;

  SuccessVehicalState({required this.data, required this.message});
}

class DeleteVehicalSuccessState extends VehicalState {
  final String message;
  final List<VechicleModel> data;
  DeleteVehicalSuccessState({required this.message, required this.data});
}

class AddVehicalSuccessState extends VehicalState {
  final String message;
  final VechicleModel vehicle;
  final List<VechicleModel> data;
  AddVehicalSuccessState({required this.vehicle, required this.message, required this.data});
}

class UpdateVehicalSuccessState extends VehicalState {
  final String message;
  final List<VechicleModel> data;
  UpdateVehicalSuccessState({required this.message, required this.data});
}

class ErrorVehicalState extends VehicalState {
  final String error;
  ErrorVehicalState({required this.error});
}
