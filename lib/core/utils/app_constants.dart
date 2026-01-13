import 'package:flutter/widgets.dart';

abstract class AppConstants {
  //------------- Strings -------------
  static const String driverMate = "Driver Mate";
  static const String loginpage = "Driver Mate";
  static const String welcomeToDriveMate = "Welcome to DriveMate";
  static const String pleaseLogin = "Please log in the form below.";
  static const String emailAddress = "Email Address";
  static const String enterYourEmail = "Enter your email address";
  static const String password = "Password";
  static const String pleaseEnterYourEmail = "Please enter your email";
  static const String pleaseEnterValidEmail = "Please enter  valid email";
  //------------- Colors -------------
  static const Color white = Color(0xffffffff);
  static const Color veryDarkBlue = Color(0xff1B3C53);
  static const Color darkBlue = Color(0xff204560);
  static const Color blue = Color(0xff234C6A);
  static const Color grey = Color(0xffA5A4A4);
  //------------- Font Names -------------
  static const String fontPoppins = "Poppins";
  static const String fontInter = "Inter";
  //------------- Font Sizes -------------
  static const double f32 = 32.0;
  static const double f16 = 16.0;
  static const double f14 = 14.0;
  static const double f11 = 11.0;
  static const double f8 = 8.0;
  //------------- Asset Paths -------------
  static const String imagesPath = "assets/images/";
  static const String carPath = "${imagesPath}car.svg";
  static const String loginImagePath = "${imagesPath}login_image.jpg";
  //widdths and heights
  double get carImageHeight => 371.0;
}
