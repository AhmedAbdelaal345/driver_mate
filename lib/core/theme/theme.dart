import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

// ── Light ──────────────────────────────────────────────────────────────────
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.white,
  fontFamily: AppFonts.fontInter,
  primaryColor: AppColors.darkBlue,

  colorScheme: const ColorScheme.light(
    primary: AppColors.darkBlue,
    secondary: AppColors.cyanColor,
    surface: AppColors.white,
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.red,
    outline: AppColors.boarderWhiteColor,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.darkBlue),
    titleTextStyle: TextStyle(
      fontSize: AppFontSize.f21,
      fontWeight: FontWeight.w600,
      color: AppColors.darkBlue,
      fontFamily: AppFonts.fontPoppins,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.cyanColor,
    unselectedItemColor: AppColors.iconGrey,
    elevation: 8,
  ),

  cardTheme: CardThemeData(
    color: AppColors.containerGrey,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    shadowColor: AppColors.boarderWhiteColor,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.containerGrey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.boarderWhiteColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.cyanColor, width: 1.5),
    ),
    hintStyle: const TextStyle(
      color: AppColors.iconGrey,
      fontSize: AppFontSize.f13,
    ),
  ),

  dividerColor: AppColors.boarderWhiteColor,
  iconTheme: const IconThemeData(color: AppColors.iconGrey),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.black),
    bodyMedium: TextStyle(color: AppColors.textGrey),
    bodySmall: TextStyle(color: AppColors.midGrey),
    titleLarge: TextStyle(
      color: AppColors.darkBlue,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(color: AppColors.darkBlue),
    titleSmall: TextStyle(color: AppColors.blueText),
    labelLarge: TextStyle(color: AppColors.white),
  ),
);

// ── Dark ───────────────────────────────────────────────────────────────────
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.black, // #111827 — deep dark
  fontFamily: AppFonts.fontInter,
  primaryColor: AppColors.cyanColor,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.cyanColor, // main actions, FABs
    secondary: AppColors.darkCyanColor, // secondary actions
    surface: AppColors.darkBlue, // #204560 — cards, sheets
    onPrimary: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.white,
    error: AppColors.red,
    outline: AppColors.blue, // #234C6A — borders
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor:
        AppColors.black, // #1B3C53 — slightly lighter than scaffold
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.white),
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: AppFontSize.f21,
      fontWeight: FontWeight.w600,
      fontFamily: AppFonts.fontPoppins,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.black, // #1B3C53
    selectedItemColor: AppColors.darkBlue,
    unselectedItemColor: AppColors.white, // #456882 — muted but visible
    elevation: 8,
  ),

  cardTheme: CardThemeData(
    color: AppColors.darkBlue, // #204560 — card surface
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    shadowColor: AppColors.black,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.veryDarkBlue, // #1B3C53 — input background
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.blue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.blue), // #234C6A
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.cyanColor, width: 1.5),
    ),
    hintStyle: const TextStyle(
      color: AppColors.blueText, // #456882 — subtle hint
      fontSize: AppFontSize.f13,
    ),
  ),

  dividerColor: AppColors.blue, // #234C6A

  iconTheme: const IconThemeData(color: AppColors.blueText), // #456882

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.white),
    bodyMedium: TextStyle(color: AppColors.iconGrey), // #9CA3AF
    bodySmall: TextStyle(color: AppColors.blueText), // #456882
    titleLarge: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: AppColors.white),
    titleSmall: TextStyle(color: AppColors.iconGrey), // #9CA3AF
    labelLarge: TextStyle(color: AppColors.white),
  ),
);
