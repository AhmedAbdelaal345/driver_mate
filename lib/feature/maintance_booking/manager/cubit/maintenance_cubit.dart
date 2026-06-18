import 'package:driver_mate/feature/maintance_booking/data/repo/maintenance_repo.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceCubit extends Cubit<MaintenanceState> {
  MaintenanceCubit(this.repo)
      : super(MaintenanceInitial());

  final MaintenanceRepo repo;

  Future<void> loadCenters() async {
    emit(MaintenanceLoading());

    try {
      final data = await repo.getNearbyCenters();

      emit(MaintenanceLoaded(data));
    } catch (e) {
      emit(MaintenanceError(e.toString()));
    }
  }
}