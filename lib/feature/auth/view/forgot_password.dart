import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/auth/manager/forget_password/forget_password_cubit.dart';
import 'package:driver_mate/feature/auth/manager/forget_password/forget_password_state.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_cubit.dart';
import 'package:driver_mate/feature/auth/view/check_your_OTP.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    //implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIcon(),
        title: Text(
          AppConstants.forgotPassword,
          style: AppStyle.forgetPasswordStyle,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: SizeConfig.width(context) * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.height(context) * 0.048),
              ContainerForIcon(iconPath: AppImagePath.messageIconPath),
              SizedBox(height: SizeConfig.height(context) * 0.03),

              Text(
                AppConstants.resetYourPassword,
                style: AppStyle.signUpTextStyle24.copyWith(
                  fontSize: AppFontSize.f20,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.001),
              Text(
                AppConstants.resetByEmail,
                style: AppStyle.hintStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.048),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  AppConstants.emailAddress,
                  style: AppStyle.labelStyle,
                ),
              ),
              TextFormFieldWidget(
                controller: emailController,
                hintText: AppConstants.enterYourEmail,
                isPassword: false,
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
              SizedBox(height: SizeConfig.height(context) * 0.07),
              Flexible(
                child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is ForgetPasswordSuccessState) {
                      AppNotifier.show(
                        context,
                        state.message,
                        type: NotifierType.success,
                      );
                      MyNavigation.navigateTo(
                        BlocProvider(
                          create: (context) => OtpCubit(),
                          child: CheckYourOTP(
                            email: emailController.text.trim(),
                          ),
                        ),
                      );
                    } else if (state is ForgetPasswordErrorState) {
                      AppNotifier.show(
                        context,
                        state.error,
                        type: NotifierType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgetPasswordLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.darkBlue,
                        ),
                      );
                    }
                    return PrimaryElevatedButtonWidget(
                      formKey: formKey,
                      onPressed: () {
                        final FormState form =
                            formKey.currentState as FormState;

                        if (form.validate()) {
                          // Implement your forgot password logic here

                          context.read<ForgetPasswordCubit>().forgetPassword(
                            emailController.text.trim(),
                          );
                        }
                      },
                      buttonText: AppConstants.continu,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
