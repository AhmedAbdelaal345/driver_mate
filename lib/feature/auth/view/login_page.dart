import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/service/local_notification_service.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_cubit.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_state.dart';
import 'package:driver_mate/feature/auth/manager/forget_password/forget_password_cubit.dart';
import 'package:driver_mate/feature/auth/view/forgot_password.dart';
import 'package:driver_mate/feature/auth/view/register_page.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
// import 'package:driver_mate/feature/auth/view/widget/social_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/home/view/wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final DateTime now = DateTime.now();
        if (AuthCubit.get(context).lastBackPressed == null ||
            now.difference(AuthCubit.get(context).lastBackPressed!) >
                const Duration(seconds: 2)) {
          AuthCubit.get(context).lastBackPressed = now;
          Fluttertoast.showToast(
            msg: AppStrings.of(context).pressBackAgainToExit,
            gravity: ToastGravity.BOTTOM,
            textColor: AppColors.white,
            backgroundColor: AppColors.darkBlue.withValues(alpha: 0.7),
          );
        } else {
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: AuthCubit.get(context).loginFormKey,
            child: Center(
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.height(context) * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImagePath.loginImagePath),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.019),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * 0.04,
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.of(context).welcomeToDriveMate,
                          style: AppStyle.welcomeTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.019),
                        Text(
                          AppStrings.of(context).pleaseLogin,
                          style: AppStyle.hintStyle,
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.049),
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            AppStrings.of(context).emailAddress,
                            style: AppStyle.labelStyle.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.015),
                        TextFormFieldWidget(
                          controller: AuthCubit.get(context).emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.of(
                                context,
                              ).pleaseEnterYourEmail;
                            } else if (RegExp(
                                  AppRegExp.emailValidationPattern,
                                ).hasMatch(value) ==
                                false) {
                              return AppStrings.of(
                                context,
                              ).pleaseEnterValidEmail;
                            }
                            return null;
                          },
                          hintText: AppStrings.of(context).enterYourEmail,
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.025),
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            AppStrings.of(context).password,
                            style: AppStyle.labelStyle.copyWith(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.015),
                        TextFormFieldWidget(
                          controller: AuthCubit.get(context).passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.of(
                                context,
                              ).pleaseEnterYourPassword;
                            } else if (RegExp(
                                  AppRegExp.passwordValidationPattern,
                                ).hasMatch(value) ==
                                false) {
                              return AppStrings.of(
                                context,
                              ).pleaseEnterValidPassword;
                            }
                            return null;
                          },
                          hintText: AppStrings.of(context).enterYourPassword,
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.012),
                        Row(
                          children: [
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width(context) * 0.04,
                              ),
                              child: TextButton(
                                child: Text(
                                  AppStrings.of(context).forgotPassword,
                                  style: AppStyle.forgetPasswordStyle,
                                ),
                                onPressed: () {
                                  // Navigate to forgot password page
                                  MyNavigation.navigateTo(
                                    BlocProvider(
                                      create: (context) =>
                                          ForgetPasswordCubit(),
                                      child: const ForgotPassword(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.015),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            // implement listener
                            if (state is LoginAuthFailure) {
                              LocalNotificationService.basicNotification(
                                notificationId: "id:2",
                                id: 1,
                                title: "Login Failuor",
                                body: "There is  problem in login ❌",
                              );
                              Fluttertoast.showToast(
                                msg: state.errorMessage,
                                gravity: ToastGravity.BOTTOM,
                                textColor: AppColors.white,
                                backgroundColor: AppColors.red,
                              );
                              print(state.errorMessage.toString());
                            } else {
                              if (state is LoginAuthSuccess) {
                                LocalNotificationService.basicNotification(
                                  notificationId: "id:1",
                                  id: 0,
                                  title: "Login Successfuly",
                                  body: "You have Logined Successfully ✅",
                                );
                                Fluttertoast.showToast(
                                  msg: "Login Successfuly",
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: AppColors.white,
                                  backgroundColor: AppColors.blue,
                                );
                                //  log(state.message);
                                AuthCubit.get(context).clearControllers();
                                // Process data.
                                // AuthCubit.get(context).resetState();
                                MyNavigation.navigateTo(const WrapperPage());
                                // AuthCubit.get(context).disposeControllers();
                              }
                            }
                          },

                          builder: (context, state) {
                            if (state is LoginAuthLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            } else {
                              return PrimaryElevatedButtonWidget(
                                formKey: AuthCubit.get(context).loginFormKey,
                                buttonText: AppStrings.of(context).loginText,
                                onPressed: () {
                                  final form = AuthCubit.get(
                                    context,
                                  ).loginFormKey.currentState!;
                                  if (form.validate()) {
                                    AuthCubit.get(context).onLoginPress();

                                    // Process data.
                                  }
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(height: SizeConfig.height(context) * 0.042),
                        DividerWidget(),
                        // SizedBox(height: SizeConfig.height(context) * 0.042),
                        // SocialButtonWidget(
                        //   textButton: AppStrings.of(context).continueWithApple,
                        //   icon: ImageIcon(
                        //     AssetImage(AppImagePath.applePath),
                        //     color: Colors.black,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        SizedBox(height: SizeConfig.height(context) * 0.042),
                        // SocialButtonWidget(
                        //   textButton: AppStrings.of(context).continueWithGoogle,
                        //   icon: Image.asset(
                        //     AppImagePath.googlePath,
                        //     width: 24, // Adjust size to match your design
                        //     height: 24,
                        //   ),
                        //   onPressed: () {},
                        // ),
                        // SizedBox(height: SizeConfig.height(context) * 0.015),
                        FooterWidget(
                          onTap: () {
                            // Navigate to signup page
                            MyNavigation.navigateTo(const RegisterPage());
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
