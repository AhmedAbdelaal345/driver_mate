import 'package:shared_preferences/shared_preferences.dart';
import '../model/saved_item_model.dart';

class SavedItemRepo {
  SavedItemRepo._singleTone();
  static final instance = SavedItemRepo._singleTone();
  factory SavedItemRepo() => instance;

  static const String _key = "saved_items";

  /// Save item
  Future<void> saveItem(SavedItemModel item) async {
    final prefs = await SharedPreferences.getInstance();

    final items = await getItems();

    items.add(item);

    final jsonList =
        items.map((e) => e.toJson()).toList();

    await prefs.setStringList(_key, jsonList);
  }

  /// Get all items
  Future<List<SavedItemModel>> getItems() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList
        .map((e) => SavedItemModel.fromJson(e))
        .toList();
  }

  /// Remove item
  Future<void> removeItem(SavedItemModel item) async {
    final prefs = await SharedPreferences.getInstance();

    final items = await getItems();

    items.removeWhere(
        (element) => element.title == item.title);

    final jsonList =
        items.map((e) => e.toJson()).toList();

    await prefs.setStringList(_key, jsonList);
  }

  /// Clear all
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}