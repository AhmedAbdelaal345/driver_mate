import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle welcomeTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static TextStyle signUpTextStyle24 = const TextStyle(
    fontSize: AppFontSize.f24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static TextStyle hintStyle = const TextStyle(
    fontSize: AppFontSize.f11,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontFamily: AppFonts.fontPoppins,
  );
  static TextStyle labelStyle = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static TextStyle forgetPasswordStyle = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: AppColors.blue,
    fontFamily: AppFonts.fontPoppins,
  );
  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );
  static TextStyle orTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
    fontFamily: AppFonts.fontInter,
  );
  static TextStyle socialButtonTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: AppFonts.fontInter,
  );
  static TextStyle signUpTextStyle = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );

  static TextStyle coursalTitleTextStyle = const TextStyle(
    fontSize: AppFontSize.f18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );
  static TextStyle coursalSubtitleTextStyle = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );

  static TextStyle titleForContainer = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontFamily: AppFonts.fontArimo,
  );

  static TextStyle titleOfContainer = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: AppFonts.fontArimo,
  );
  static TextStyle viewAll = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: AppColors.cyanColor,
    fontFamily: AppFonts.fontArimo,
  );

  static TextStyle containerSubtitle = const TextStyle(
    fontSize: AppFontSize.f12,
    fontWeight: FontWeight.bold,
    color: AppColors.grey,
    fontFamily: AppFonts.fontArimo,
  );

  static TextStyle stateContainerStyle = const TextStyle(
    fontSize: AppFontSize.f12,
    fontWeight: FontWeight.bold,
    color: AppColors.orange,
    fontFamily: AppFonts.fontArimo,
  );
}
