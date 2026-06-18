import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_cubit.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_state.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_register_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            MyNavigation.navigateBack();
          },
          icon: Icon(Icons.arrow_back_ios, size: 18,color:Theme.of(context).iconTheme.color ,),
        ),
        title: Text(
          AppStrings.of(context).createAccount,
          style: AppStyle.welcomeTextStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        centerTitle: true,
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
                Text(
                  AppStrings.of(context).signup,
                  style: AppStyle.signUpTextStyle24.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  AppStrings.of(context).accountToContinue,
                  style: AppStyle.hintStyle.copyWith(
                    color:Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.022),
                Text(
                  AppStrings.of(context).fullName,
                  style: AppStyle.labelStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),

                TextFormFieldWidget(
                  controller: AuthCubit.get(context).nameController,
                  hintText: AppStrings.of(context).enterYourName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourName;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(
                  AppStrings.of(context).emailAddress,
                  style: AppStyle.labelStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).emailController,
                  hintText: AppStrings.of(context).enterYourEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourEmail;
                    } else if (RegExp(
                          AppRegExp.emailValidationPattern,
                        ).hasMatch(value) ==
                        false) {
                      return AppStrings.of(context).pleaseEnterValidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(
                  AppStrings.of(context).password,
                  style: AppStyle.labelStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).passwordController,
                  hintText: AppStrings.of(context).enterYourPassword,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourPassword;
                    } else if (RegExp(
                          AppRegExp.passwordValidationPattern,
                        ).hasMatch(value) ==
                        false) {
                      return AppStrings.of(context).pleaseEnterValidPassword;
                    }
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                Text(
                  AppStrings.of(context).confirmPassword,
                  style: AppStyle.labelStyle.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.01),
                TextFormFieldWidget(
                  controller: AuthCubit.get(context).confirmPasswordController,
                  hintText: AppStrings.of(context).reEnterYourPassword,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourPassword;
                    } else if (AuthCubit.get(context).passwordController.text !=
                        AuthCubit.get(context).confirmPasswordController.text) {
                      return AppStrings.of(context).pleaseEnterValidPassword;
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
                    Text(
                      AppStrings.of(context).agreeWith,
                      style: AppStyle.labelStyle.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    Text(
                      AppStrings.of(context).termsAndConditions,
                      style: AppStyle.labelStyle.copyWith(
                        decoration: TextDecoration.underline,
                        color:Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(context) * 0.07),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is RegisterAuthSuccess) {
                      AppNotifier.show(
                        context,
                        state.message,
                        type: NotifierType.success,
                      );

                      AuthCubit.get(context).clearControllers();

                      MyNavigation.navigateBack();
                    } else if (state is RegisterAuthFailure) {
                      AppNotifier.show(
                        context,
                        state.errorMessage,
                        type: NotifierType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterAuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,),
                      );
                    } else {
                      return PrimaryElevatedButtonWidget(
                        formKey: AuthCubit.get(context).registerFormKey,
                        buttonText: AppStrings.of(context).signup,
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
                                msg: AppStrings.of(context).pleaseAgreeToTerms,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Theme.of(context).colorScheme.primary.withValues(
                                  alpha: 0.7,
                                ),
                                textColor: Theme.of(context).colorScheme.onPrimary,
                                fontSize: AppFontSize.f16,
                              );
                              return;
                            }
                            AuthCubit.get(context).onRegisterPress();
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
