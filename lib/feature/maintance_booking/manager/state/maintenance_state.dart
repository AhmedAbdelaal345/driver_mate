import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';

abstract class MaintenanceState {}

class MaintenanceInitial extends MaintenanceState {}

class MaintenanceLoading extends MaintenanceState {}

class MaintenanceLoaded extends MaintenanceState {
  final List<ServiceCenterModel> centers;

  MaintenanceLoaded(this.centers);
}

class MaintenanceError extends MaintenanceState {
  final String error;

  MaintenanceError(this.error);
}