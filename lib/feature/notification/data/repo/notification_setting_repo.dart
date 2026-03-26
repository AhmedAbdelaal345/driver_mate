// data/repo/notification_settings_repo.dart

import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsRepo {
  static const _maintenance = "maintenance";
  static const _offers = "offers";
  static const _ai = "ai";
  static const _emergency = "emergency";

  Future<Map<String, bool>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      _maintenance: prefs.getBool(_maintenance) ?? true,
      _offers: prefs.getBool(_offers) ?? true,
      _ai: prefs.getBool(_ai) ?? true,
      _emergency: prefs.getBool(_emergency) ?? true,
    };
  }

  Future<void> updateSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}