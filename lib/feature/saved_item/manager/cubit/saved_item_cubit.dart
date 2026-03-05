import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/saved_item_model.dart';
import '../../data/repo/saved_item_repo.dart';

class SavedItemCubit extends Cubit<SavedItemState> {
  final SavedItemRepo repo;
  SavedSortType _currentSort = SavedSortType.mostRecent;
  SavedItemCubit(this.repo) : super(SavedItemInitial());
  Future<void> loadItems() async {
    emit(SavedItemLoading());
    try {
      final items = await repo.getItems();
      final sorted = _applySort(items);

      emit(SavedItemLoaded(sorted, _currentSort));
    } catch (e) {
      emit(SavedItemError(e.toString()));
    }
  }

  Future<void> addItem(SavedItemModel item) async {
    emit(SavedItemLoading());
    try {
      await repo.saveItem(item);
      loadItems();
      emit(SavedItemAdded());
    } on Exception catch (e) {
      emit(SavedItemError(e.toString()));
    }
  }

  Future<void> removeItem(SavedItemModel item) async {
    emit(SavedItemLoading());

    try {
      await repo.removeItem(item);
      loadItems();
      emit(SavedItemRemoved());
    } on Exception catch (e) {
      emit(SavedItemError(e.toString()));
    }
  }

  Future<void> clearAll() async {
    await repo.clearAll();
    loadItems();
  }

  void changeSort(SavedSortType type) async {
    _currentSort = type;
    loadItems();
  }

  List<SavedItemModel> _applySort(List<SavedItemModel> items) {
    final list = [...items];

    switch (_currentSort) {
      case SavedSortType.mostRecent:
        list.sort((a, b) => b.hashCode.compareTo(a.hashCode));
        break;

      case SavedSortType.oldestFirst:
        list.sort((a, b) => a.hashCode.compareTo(b.hashCode));
        break;

      case SavedSortType.byType:
        list.sort((a, b) => a.type.name.compareTo(b.type.name));
        break;
    }

    return list;
  }
}
