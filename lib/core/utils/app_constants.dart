import 'package:flutter/widgets.dart';

abstract class AppConstants {
  //------------- Strings -------------
  static const String driverMate = "Driver Mate";
  static const String loginText = "Login";
  static const String welcomeToDriveMate = "Welcome to DriveMate";
  static const String pleaseLogin = "Please log in the form below.";
  static const String emailAddress = "Email Address";
  static const String checkYourEmail = "Check your email";
  static const String enterYourEmail = "Enter your email address";
  static const String enterYourName = "Enter your name";
  static const String pleaseEnterYourName = "Please, enter your name";
  static const String enterYourPassword = "Enter your password";
  static const String reEnterYourPassword = "Enter your new password";
  static const String password = "Password";
  static const String confirm = "Confirm";
  static const String confirmPassword = "Confirm Password";
  static const String doesntMatch = "The password doesn't match";
  static const String fullName = "Full Name";
  static const String continu = "Continue";
  static const String forgotPassword = "Forgot Password";
  static const String accountToContinue = "Create account to continue";
  static const String pleaseEnterYourEmail = "Please enter your email";
  static const String pleaseEnterYourPassword = "Please enter your password";
  static const String pleaseEnterValidEmail = "Please enter  valid email";
  static const String pleaseEnterValidPassword = "Please enter  valid password";
  static const String continueWithApple = "Login with Apple";
  static const String continueWithGoogle = "Login with Google";
  static const String dontHaveAccount = "Don't have an account? ";
  static const String signup = "Sign Up";
  static const String updatePassword = "Update password";
  static const String resetByEmail =
      "Please enter your email to reset the password";
  static const String pleaseEnterTheCode = "Please enter the code";
  static const String verifyCode = "Verify code";
  static const String resendCode = "Resend Code";
  static const String dontGotEmail = "Haven't got the email? ";
  static const String confirmPasswordText =
      "Your password has been successfully reset.Click confirm to reset the password. ";
  static const String setNewPasswordText = "Set a new password ";
  static const String setNewPasswordHintText =
      "Create a new password.Ensure it is differs fromprevious one for security.";
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
  static const double f13 = 13.0;
  static const double f11 = 11.0;
  static const double f8 = 8.0;
  static const double f2 = 2.0;
  static const double f21 = 21.0;
  static const double f20 = 20.0;
  static const double f24 = 24.0;
  static const double f25 = 25.0;
  //------------- Asset Paths -------------
  static const String imagesPath = "assets/images/";
  static const String carPath = "${imagesPath}car.svg";
  static const String googlePath = "${imagesPath}google.png";
  static const String applePath = "${imagesPath}apple.png";
  static const String loginImagePath = "${imagesPath}login_image.jpg";
  static const String arrowBackPath = "${imagesPath}arrow_back.svg";
  static const String facebookPath = "${imagesPath}facebook.svg";
  static const String correctMarkPath = "${imagesPath}correct_mark.svg";
  //widdths and heights
  double get carImageHeight => 371.0;
  //------------- Regex -------------
  static const String emailValidationPattern =
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String passwordValidationPattern =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  //------------- Routes -------------
  static const String signupPage = "/signup_page";
  static const String loginPage = "/login_page";
  static const String forgotPasswordPage = "/forgot_password_page";
  static const String checkPasswordPage = "/check_password_page";
  static const String confirmPasswordPage = "/confirm_password_page";
  static const String setNewPassword = "/set_new_password";
}
