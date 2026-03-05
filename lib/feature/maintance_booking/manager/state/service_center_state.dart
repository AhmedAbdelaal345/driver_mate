import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';

class ServiceCenterState {}

class ServiceCenterInitial extends ServiceCenterState {}

class ServiceCenterLoading extends ServiceCenterState {}

class ServiceCenterLoaded extends ServiceCenterState {
  final List<ServiceCenterModel>
  serviceCenters; // Replace with your actual data model

  ServiceCenterLoaded(this.serviceCenters);
}

class ServiceCenterError extends ServiceCenterState {
  final String message;

  ServiceCenterError(this.message);
}
