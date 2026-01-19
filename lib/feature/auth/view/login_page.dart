import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_state.dart';
import 'package:driver_mate/feature/auth/view/forgot_password.dart';
import 'package:driver_mate/feature/auth/view/register_page.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/social_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        AppConstants.welcomeToDriveMate,
                        style: AppStyle.welcomeTextStyle,
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.019),
                      Text(AppConstants.pleaseLogin, style: AppStyle.hintStyle),
                      SizedBox(height: SizeConfig.height(context) * 0.049),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          AppConstants.emailAddress,
                          style: AppStyle.labelStyle,
                        ),
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.015),
                      TextFormFieldWidget(
                        controller: AuthCubit.get(context).emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.pleaseEnterYourEmail;
                          } else if (RegExp(
                                AppRegExp.emailValidationPattern,
                              ).hasMatch(value) ==
                              false) {
                            return AppConstants.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                        hintText: AppConstants.enterYourEmail,
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.025),
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          AppConstants.password,
                          style: AppStyle.labelStyle,
                        ),
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.015),
                      TextFormFieldWidget(
                        controller: AuthCubit.get(context).passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.pleaseEnterYourPassword;
                          } else if (RegExp(
                                AppRegExp.passwordValidationPattern,
                              ).hasMatch(value) ==
                              false) {
                            return AppConstants.pleaseEnterValidPassword;
                          }
                          return null;
                        },
                        hintText: AppConstants.enterYourPassword,
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
                                AppConstants.forgotPassword,
                                style: AppStyle.forgetPasswordStyle,
                              ),
                              onPressed: () {
                                // Navigate to forgot password page
                                MyNavigation.navigateTo(ForgotPassword());
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
                            Fluttertoast.showToast(
                              msg: state.errorMessage,
                              gravity: ToastGravity.BOTTOM,
                              textColor: AppColors.white,
                              backgroundColor: AppColors.red,
                            );
                          } else {
                            if (state is LoginAuthSuccess) {
                              Fluttertoast.showToast(
                                msg: state.message,
                                gravity: ToastGravity.BOTTOM,
                                textColor: AppColors.white,
                                backgroundColor: AppColors.blue,
                              );
                              AuthCubit.get(context).clearControllers();
                              // Process data.
                              AuthCubit.get(context).resetState();
                              // AuthCubit.get(context).disposeControllers();
                            }
                          }
                        },

                        builder: (context, state) {
                          if (state is LoginAuthLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blue,
                              ),
                            );
                          } else {
                            return PrimaryElevatedButtonWidget(
                              formKey: AuthCubit.get(context).loginFormKey,
                              buttonText: AppConstants.loginText,
                              onPressed: () {
                                final form = AuthCubit.get(
                                  context,
                                ).loginFormKey.currentState!;
                                if (form.validate()) {
                                  AuthCubit.get(context).onLoginPress();

                                  AuthCubit.get(context).clearControllers();
                                  // Process data.
                                  AuthCubit.get(context).resetState();
                                }
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.042),
                      DividerWidget(),
                      SizedBox(height: SizeConfig.height(context) * 0.042),
                      SocialButtonWidget(
                        textButton: AppConstants.continueWithApple,
                        icon: ImageIcon(
                          AssetImage(AppImagePath.applePath),
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.042),
                      SocialButtonWidget(
                        textButton: AppConstants.continueWithGoogle,
                        icon: Image.asset(
                          AppImagePath.googlePath,
                          width: 24, // Adjust size to match your design
                          height: 24,
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(height: SizeConfig.height(context) * 0.015),
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
    );
  }
}
