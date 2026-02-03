import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/stack_with_container_widget.dart';
import 'package:driver_mate/feature/auth/view/confirm_password_page.dart';
import 'package:driver_mate/feature/auth/view/widget/check_textfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class CheckYourEmail extends StatefulWidget {
  const CheckYourEmail({super.key, required this.email});
  final String email;

  @override
  State<CheckYourEmail> createState() => _CheckYourEmailState();
}

class _CheckYourEmailState extends State<CheckYourEmail> {
  final List<TextEditingController> _codeControllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIcon(),
        title: Text(AppConstants.verifyOTP, style: AppStyle.welcomeTextStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.035 * SizeConfig.width(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.047),
                StackWithContainerWidget(),

                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                Text(
                  AppConstants.checkYourEmail,
                  style: AppStyle.labelStyle.copyWith(fontSize: 26),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Text(
                  "We sent a 6-digit code to your email",
                  style: AppStyle.hintStyle,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  widget.email,
                  style: AppStyle.labelStyle.copyWith(fontSize: 12),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text("Code expires in 10 minutes.", style: AppStyle.hintStyle),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                /// FIX: استخدم Row بدل ListView
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => SizedBox(
                      width: 50,
                      child: CheckTextfieldWidget(
                        controller: _codeControllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.pleaseEnterTheCode;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 0.06 * SizeConfig.height(context)),

                PrimaryElevatedButtonWidget(
                  formKey: formKey,
                  buttonText: AppConstants.verifyCode,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      MyNavigation.navigateTo(ConfirmPasswordPage());
                    }
                  },
                ),

                SizedBox(height: 0.032 * SizeConfig.height(context)),

                Row(
                  children: [
                    Text(
                      AppConstants.dontHaveAccount,
                      style: AppStyle.hintStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        // هنا هيتعمل resend code
                      },
                      child: Text(
                        AppConstants.resendCode,
                        style: AppStyle.signUpTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
