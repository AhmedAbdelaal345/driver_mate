import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';
import 'package:driver_mate/feature/maintance_history/data/repo/maintance_history_repo.dart';
import 'package:driver_mate/feature/maintance_history/manager/state/maintence_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenceHistoryCubit extends Cubit<MaintenceHistoryState> {
  final MaintanceHistoryRepo repo;

  MaintenceHistoryCubit(this.repo) : super(MaintenceHistoryInititailState());

  /// Load items
  Future<void> loadItems() async {
    emit(MaintenceHistoryLoadingState());

    try {
      final items = await repo.loadItem();
      emit(MaintenceHistorySuccessState(items: items));
    } catch (e) {
      emit(MaintenceHistoryErrorState(message: e.toString()));
    }
  }

  /// Add item
  Future<void> addItem(MaintanceHistoryModel item) async {
    try {
      await repo.addItem(item: item);

      final items = await repo.loadItem();

      emit(MaintenceHistorySuccessState(items: items));
    } catch (e) {
      emit(MaintenceHistoryErrorState(message: e.toString()));
    }
  }

  /// Remove item
  Future<void> removeItem(MaintanceHistoryModel item) async {
    try {
      await repo.removeItem(item);

      final items = await repo.loadItem();

      emit(MaintenceHistorySuccessState(items: items));
    } catch (e) {
      emit(MaintenceHistoryErrorState(message: e.toString()));
    }
  }

  /// Clear history
  Future<void> clearItems() async {
    try {
      await repo.clearItems();
      emit(MaintenceHistorySuccessState(items: []));
    } catch (e) {
      emit(MaintenceHistoryErrorState(message: e.toString()));
    }
  }
}
