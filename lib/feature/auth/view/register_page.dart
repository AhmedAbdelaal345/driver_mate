import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_register_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    bool isAgreed = false;
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          AppConstants.arrowBackPath,
          height: SizeConfig.height(context) * 0.024,
          width: SizeConfig.width(context) * 0.024,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.053 * SizeConfig.height(context),
          ),
          child: Column(
            children: [
              Text(AppConstants.signup, style: AppStyle.signUpTextStyle24),
              Text(AppConstants.accountToContinue, style: AppStyle.hintStyle),
              SizedBox(height: SizeConfig.height(context) * 0.022),
              Text(AppConstants.fullName, style: AppStyle.labelStyle),
              SizedBox(height: SizeConfig.height(context) * 0.01),

              TextFormFieldWidget(
                controller: nameController,
                hintText: AppConstants.enterYourName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.pleaseEnterYourName;
                  }
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              Text(AppConstants.emailAddress, style: AppStyle.labelStyle),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              TextFormFieldWidget(
                controller: emailController,
                hintText: AppConstants.enterYourEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.pleaseEnterYourEmail;
                  } else if (RegExp(
                        AppConstants.emailValidationPattern,
                      ).hasMatch(value) ==
                      false) {
                    return AppConstants.pleaseEnterValidEmail;
                  }
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              Text(AppConstants.password, style: AppStyle.labelStyle),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              TextFormFieldWidget(
                controller: passwordController,
                hintText: AppConstants.enterYourPassword,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.pleaseEnterYourName;
                  } else if (RegExp(
                        AppConstants.passwordValidationPattern,
                      ).hasMatch(value) ==
                      false) {
                    return AppConstants.pleaseEnterValidPassword;
                  }
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              Text(AppConstants.confirmPassword, style: AppStyle.labelStyle),
              SizedBox(height: SizeConfig.height(context) * 0.01),
              TextFormFieldWidget(
                controller: confirmPasswordController,
                hintText: AppConstants.reEnterYourPassword,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppConstants.pleaseEnterYourName;
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return AppConstants.pleaseEnterValidPassword;
                  }
                },
              ),
              SizedBox(height: 0.18 * SizeConfig.height(context)),
              Row(
                children: [
                  Checkbox(
                    value: isAgreed,
                    onChanged: (value) {
                      isAgreed = value!;

                      //we will link it with backend later
                    },
                    checkColor: AppConstants.white,
                    activeColor: AppConstants.blue,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.f2),
                    ),
                  ),
                  Text("Agree with ", style: AppStyle.labelStyle),
                  Text(
                    "Terms & Conditions",
                    style: AppStyle.labelStyle.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppConstants.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.07),
              PrimaryElevatedButtonWidget(
                formKey: _formKey,
                buttonText: "Sign Up",
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
    );
  }
}
