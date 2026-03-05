import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';

enum SavedSortType { mostRecent, oldestFirst, byType }

abstract class SavedItemState {}

class SavedItemInitial extends SavedItemState {}
class SavedItemAdded extends SavedItemState {}
class SavedItemRemoved extends SavedItemState {}

class SavedItemLoading extends SavedItemState {}

class SavedItemLoaded extends SavedItemState {
  final List<SavedItemModel> items;
  final SavedSortType sortType;

  SavedItemLoaded(this.items, this.sortType);
}

class SavedItemError extends SavedItemState {
  final String message;
  SavedItemError(this.message);
}
