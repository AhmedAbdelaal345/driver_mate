import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/auth/view/register_page.dart';
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
        
             ),
             routes: {
              AppConstants.signupPage: (context) => const RegisterPage(),
             },
      home: const SplachPage(),
    );
  }
}