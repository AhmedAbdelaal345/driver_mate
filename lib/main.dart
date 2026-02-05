import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:driver_mate/core/utils/app_routes.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:driver_mate/feature/auth/view/confirm_password_page.dart';
import 'package:driver_mate/feature/auth/view/forgot_password.dart';
import 'package:driver_mate/feature/auth/view/login_page.dart';
import 'package:driver_mate/feature/auth/view/register_page.dart';
import 'package:driver_mate/feature/auth/view/set_new_password.dart';
import 'package:driver_mate/feature/home/view/wrapper_page.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthCubit())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.driverMate,
        theme: ThemeData(
          fontFamily: AppFonts.fontInter,
          primaryColor: AppColors.darkBlue,

          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: AppFontSize.f21,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
              fontFamily: AppFonts.fontPoppins,
            ),
          ),
        ),
        routes: {
          AppRoutes.signupPage: (context) => const RegisterPage(),
          AppRoutes.forgotPasswordPage: (context) => const ForgotPassword(),
          AppRoutes.confirmPasswordPage: (context) =>
              const ConfirmPasswordPage(),
          AppRoutes.setNewPassword: (context) => const SetNewPasswordPage(),
          AppRoutes.loginPage: (context) => const LoginPage(),
        },
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EditProfileCubit(repo: EditProfileRepo()),
            ),
          ],
          child: const WrapperPage(),
        ),
      ),
    );
  }
}
