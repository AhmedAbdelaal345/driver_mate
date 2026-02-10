import 'package:driver_mate/feature/maintance_booking/data/repo/tip_repo.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/tip_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceTipCubit extends Cubit<MaintenanceTipState> {
  final MaintenanceTipRepo repo;

  MaintenanceTipCubit(this.repo) : super(MaintenanceTipInitial());

  Future<void> loadTip() async {
    emit(MaintenanceTipLoading());

    try {
      final tip = await repo.getTip();
      emit(MaintenanceTipLoaded(tip));
    } catch (e) {
      emit(MaintenanceTipError(e.toString()));
    }
  }
}
