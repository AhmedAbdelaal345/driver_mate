import 'package:driver_mate/feature/maintance_booking/data/model/maintenance_tip_model.dart';

abstract class MaintenanceTipState {}

class MaintenanceTipInitial extends MaintenanceTipState {}

class MaintenanceTipLoading extends MaintenanceTipState {}

class MaintenanceTipLoaded extends MaintenanceTipState {
  final MaintenanceTipModel tip;
  MaintenanceTipLoaded(this.tip);
}

class MaintenanceTipError extends MaintenanceTipState {
  final String message;
  MaintenanceTipError(this.message);
}
