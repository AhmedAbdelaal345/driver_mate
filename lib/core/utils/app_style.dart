import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle welcomeTextStyle = const TextStyle(
    fontSize: AppConstants.f16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: AppConstants.fontPoppins,
  );
  static TextStyle hintStyle =const TextStyle(
    fontSize: AppConstants.f11,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
    fontFamily: AppConstants.fontPoppins,
  );
  static TextStyle labelStyle =const TextStyle(
    fontSize: AppConstants.f14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: AppConstants.fontPoppins,
  );
}
