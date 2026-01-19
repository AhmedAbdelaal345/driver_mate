import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_state.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_register_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppImagePath.arrowBackPath,
            height: SizeConfig.height(context) * 0.024,
            width: SizeConfig.width(context) * 0.024,
          ),
        ),
      ),
      body: Form(
        key: AuthCubit.get(context).registerFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.03 * SizeConfig.height(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppConstants.signup, style: AppStyle.signUpTextStyle24),
                Text(AppConstants.accountToContinue, style: AppStyle.hintStyle),
                SizedBox(height: SizeConfig.height(context) * 0.022),
                Text(AppConstants.fullName, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.01),

                TextFormFieldWidget(
                  controller: AuthCubit.get(context).nameController,
                  hintText: AppConstants.enterYourName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.pleaseEnterYourName;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(AppConstants.emailAddress, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).emailController,
                  hintText: AppConstants.enterYourEmail,
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
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(AppConstants.password, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).passwordController,
                  hintText: AppConstants.enterYourPassword,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.pleaseEnterYourName;
                    } else if (RegExp(
                          AppRegExp.passwordValidationPattern,
                        ).hasMatch(value) ==
                        false) {
                      return AppConstants.pleaseEnterValidPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(AppConstants.confirmPassword, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).confirmPasswordController,
                  hintText: AppConstants.reEnterYourPassword,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.pleaseEnterYourName;
                    } else if (AuthCubit.get(context).passwordController.text !=
                        AuthCubit.get(context).confirmPasswordController.text) {
                      return AppConstants.pleaseEnterValidPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 0.018 * SizeConfig.height(context)),
                Row(
                  children: [
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return Checkbox(
                          value: AuthCubit.get(context).isAgreed,
                          onChanged: (value) {
                            AuthCubit.get(context).toggleAgree(value!);
                            //we will link it with backend later
                          },
                          checkColor: AppColors.white,
                          activeColor: AppColors.blue,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(AppFontSize.f2),
                            side: BorderSide(
                              width: AppFontSize.f1 / 5,
                              color: AppColors.darkBlue,
                            ),
                          ),
                        );
                      },
                    ),
                    Text("Agree with ", style: AppStyle.labelStyle),
                    Text(
                      "Terms & Conditions",
                      style: AppStyle.labelStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(context) * 0.07),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is RegisterAuthSuccess) {
                      Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.darkBlue.withOpacity(0.7),
                        textColor: AppColors.white,
                        fontSize: AppFontSize.f16,
                      );
                      AuthCubit.get(context).clearControllers();

                      Navigator.pop(context);
                    } else if (state is RegisterAuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterAuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.blue),
                      );
                    } else {
                      return PrimaryElevatedButtonWidget(
                        formKey: AuthCubit.get(context).registerFormKey,
                        buttonText: AppConstants.signup,
                        onPressed: () {
                          final FormState form =
                              AuthCubit.get(
                                    context,
                                  ).registerFormKey.currentState
                                  as FormState;
                          if (form.validate()) {
                            // Proceed with registration logic

                            if (!AuthCubit.get(context).isAgreed) {
                              Fluttertoast.showToast(
                                msg: AppConstants.pleaseAgreeToTerms,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: AppColors.darkBlue.withOpacity(
                                  0.7,
                                ),
                                textColor: AppColors.white,
                                fontSize: AppFontSize.f16,
                              );
                              return;
                            }
                            AuthCubit.get(context).onRegisterPress();
                            AuthCubit.get(context).clearControllers();
                          }
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.054),
                DividerWidget(),
                SizedBox(height: SizeConfig.height(context) * 0.036),
                FooterRegisterWidget(),
                SizedBox(height: 0.083 * SizeConfig.height(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
