import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/check_textfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';

class CheckYourEmail extends StatelessWidget {
  const CheckYourEmail({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ImageIcon(AssetImage(AppConstants.arrowBackPath)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.035 * SizeConfig.width(context),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.047),
              Text(AppConstants.checkYourEmail, style: AppStyle.labelStyle),

              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "We sent a reset link to $email enter 5 digit code that mentioned in the email",
                style: AppStyle.hintStyle,
              ),
              SizedBox(height: 0.022),
              ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CheckTextfieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.pleaseEnterTheCode;
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(height: 0.1 * SizeConfig.height(context)),
              PrimaryElevatedButtonWidget(formKey: formKey, buttonText: AppConstants.verifyCode, onPressed: (){
                if (formKey.currentState != null &&
                    formKey.currentState!.validate()) {
                  // Implement your verification logic here
                 Navigator.pushNamed(context, AppConstants.confirmPasswordPage); 
                }
              }),
              SizedBox(height:0.032*SizeConfig.height(context),),
              Row(
                children: [
                  Text(AppConstants.dontHaveAccount, style: AppStyle.hintStyle),
                  TextButton(
                    onPressed: () {
                      // here we will implement resend code functionality
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
    );
  }
}
