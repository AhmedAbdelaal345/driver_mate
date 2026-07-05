import 'package:driver_mate/feature/cartips/data/repo/car_tip_list_repo.dart';
import 'package:driver_mate/feature/cartips/manager/state/car_tip_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarTipListCubit extends Cubit<CarTipState> {
  final CarTipLsitRepo repo;

  CarTipListCubit(this.repo) : super(CarTipInitial());

  Future<void> loadTip() async {
    emit(CarTipLoading());
    try {
      final tip = await repo.getTip();
      tip.fold(
        (l) {
          emit(CarTipError(l));
        },
        (r) {
          emit(CarTipLoaded(r));
        },
      );
    } catch (e) {
      emit(CarTipError(e.toString()));
    }
  }
}
