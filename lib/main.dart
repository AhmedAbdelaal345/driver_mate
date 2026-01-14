import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/auth/view/check_your_password.dart';
import 'package:driver_mate/feature/auth/view/confirm_password_page.dart';
import 'package:driver_mate/feature/auth/view/forgot_password.dart';
import 'package:driver_mate/feature/auth/view/login_page.dart';
import 'package:driver_mate/feature/auth/view/register_page.dart';
import 'package:driver_mate/feature/auth/view/set_new_password.dart';
import 'package:driver_mate/feature/splach/view/splach_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Mate',
      theme: ThemeData(
        fontFamily: AppConstants.fontInter,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: AppConstants.f21,
            fontWeight: FontWeight.w600,
            color: AppConstants.darkBlue,
            fontFamily: AppConstants.fontPoppins,
          ),
        ),
      ),
      routes: {
        AppConstants.signupPage: (context) => const RegisterPage(),
        AppConstants.forgotPasswordPage: (context) => const ForgotPassword(),
        AppConstants.confirmPasswordPage: (context) =>
            const ConfirmPasswordPage(),
        AppConstants.setNewPassword: (context) => const SetNewPasswordPage(),
        AppConstants.loginPage: (context) => const LoginPage(),
      },
      home: const SplachPage(),
    );
  }
}
