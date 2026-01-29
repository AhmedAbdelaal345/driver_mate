import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static const TextStyle welcomeTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static const TextStyle signUpTextStyle24 = const TextStyle(
    fontSize: AppFontSize.f24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static const TextStyle hintStyle = const TextStyle(
    fontSize: AppFontSize.f11,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontFamily: AppFonts.fontPoppins,
  );
  static const TextStyle labelStyle = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );
  static const TextStyle forgetPasswordStyle = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: AppColors.blue,
    fontFamily: AppFonts.fontPoppins,
  );
  static const TextStyle buttonTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );
  static const TextStyle orTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
    fontFamily: AppFonts.fontInter,
  );
  static const TextStyle socialButtonTextStyle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: AppFonts.fontInter,
  );
  static const TextStyle signUpTextStyle = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: AppFonts.fontPoppins,
  );

  static const TextStyle coursalTitleTextStyle = const TextStyle(
    fontSize: AppFontSize.f18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );
  static const TextStyle coursalSubtitleTextStyle = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontFamily: AppFonts.fontInter,
  );

  static const TextStyle titleForContainer = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontFamily: AppFonts.fontArimo,
  );

  static const TextStyle titleOfContainer = const TextStyle(
    fontSize: AppFontSize.f14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: AppFonts.fontArimo,
  );
  static const TextStyle viewAll = const TextStyle(
    fontSize: AppFontSize.f13,
    fontWeight: FontWeight.w400,
    color: AppColors.cyanColor,
    fontFamily: AppFonts.fontArimo,
  );

  static const TextStyle containerSubtitle = const TextStyle(
    fontSize: AppFontSize.f12,
    fontWeight: FontWeight.bold,
    color: AppColors.grey,
    fontFamily: AppFonts.fontArimo,
  );
  static const TextStyle containerBlodSubtitle = const TextStyle(
    fontSize: AppFontSize.f16,
    fontWeight: FontWeight.bold,
    color: AppColors.cyanColor,
    fontFamily: AppFonts.fontArimo,
  );

  static const TextStyle stateContainerStyle = const TextStyle(
    fontSize: AppFontSize.f12,
    fontWeight: FontWeight.bold,
    color: AppColors.orange,
    fontFamily: AppFonts.fontArimo,
  );
  static const TextStyle smallContainerText = const TextStyle(
    fontSize: AppFontSize.f10,
    fontWeight: FontWeight.normal,
    color: AppColors.blueText,
    fontFamily: AppFonts.fontArimo,
  );
}
