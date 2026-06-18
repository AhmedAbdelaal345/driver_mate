import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCode = prefs.getString('language_code');

    if (savedCode != null) {
      final locale = Locale(savedCode);

      Get.updateLocale(locale);
      emit(locale);

      return;
    }

    final deviceLanguage = PlatformDispatcher.instance.locale.languageCode;

    final locale = deviceLanguage == 'ar'
        ? const Locale('ar')
        : const Locale('en');

    Get.updateLocale(locale);
    emit(locale);
  }

  Future<void> changeLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
    final locale = Locale(code);
    Get.updateLocale(locale); // sync GetX immediately
    emit(locale);
  }
}
