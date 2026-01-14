import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/check_your_password.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppConstants.arrowBackPath,
            height: 0.024 * MediaQuery.of(context).size.height,
            width: 0.024 * MediaQuery.of(context).size.width,
          ),
        ),
        title: Text(AppConstants.forgotPassword),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: SizeConfig.width(context) * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.height(context) * 0.048),
              Text(
                AppConstants.forgotPassword,
                style: AppStyle.signUpTextStyle24.copyWith(
                  fontSize: AppConstants.f20,
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
                        AppConstants.emailValidationPattern,
                      ).hasMatch(value) ==
                      false) {
                    return AppConstants.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.07),
              PrimaryElevatedButtonWidget(
                formKey: formKey,
                onPressed: () {
                  final FormState form = formKey.currentState as FormState;
                  if (form.validate()) {
                    // Implement your forgot password logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CheckYourEmail(email: emailController.text.trim()),
                      ),
                    );
                  }
                },
                buttonText: AppConstants.continu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
