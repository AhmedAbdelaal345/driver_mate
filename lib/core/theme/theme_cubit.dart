import 'package:driver_mate/core/theme/theme.dart';
import 'package:driver_mate/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  static const String _themeKey = 'theme_mode';

  // ── Set theme + persist ───────────────────────────────────────────────────
  Future<void> setTheme(ThemeData theme) async {
    _themeData = theme;

    final isDark = theme == darkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark); // ✅ actually saves

    emit(ThemeChanged(isDark ? 'dark' : 'light'));
  }

  // ── Load saved theme on app start ────────────────────────────────────────
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getBool(_themeKey);

    // User already selected a theme before
    if (savedTheme != null) {
      _themeData = savedTheme ? darkMode : lightMode;

      emit(ThemeChanged(savedTheme ? 'dark' : 'light'));
      return;
    }

    // First launch -> use phone theme
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final isDark = brightness == Brightness.dark;

    _themeData = isDark ? darkMode : lightMode;

    emit(ThemeChanged(isDark ? 'dark' : 'light'));
  }

  // ── Toggle (used from quick toggle buttons) ───────────────────────────────
  Future<void> toggleTheme() async {
    await setTheme(_themeData == lightMode ? darkMode : lightMode);
  }

  bool get isDark => _themeData == darkMode;
}
