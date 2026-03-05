import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/maintance_history_model.dart';

class MaintanceHistoryRepo {
  MaintanceHistoryRepo._singleTone();

  static final MaintanceHistoryRepo _instance =
      MaintanceHistoryRepo._singleTone();

  factory MaintanceHistoryRepo() => _instance;

  List<MaintanceHistoryModel> items = [];

  Future<List<MaintanceHistoryModel>> loadItem() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final stringList = prefs.getStringList("maintanceItems");

      if (stringList != null) {
        items = stringList
            .map((e) => MaintanceHistoryModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    }

    return items;
  }

  Future<void> addItem({required MaintanceHistoryModel item}) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final stringList = prefs.getStringList("maintanceItems") ?? [];

      stringList.add(item.toJson());

      await prefs.setStringList("maintanceItems", stringList);

      items.add(item);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeItem(MaintanceHistoryModel item) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      items.removeWhere(
        (e) => e.centerName == item.centerName && e.date == item.date,
      );

      final updatedList = items.map((e) => e.toJson()).toList();

      await prefs.setStringList("maintanceItems", updatedList);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> clearItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      items.clear();

      await prefs.remove("maintanceItems");
    } catch (e) {
      log(e.toString());
    }
  }
}
