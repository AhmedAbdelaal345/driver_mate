import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/social_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: SizeConfig.height(context) * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppConstants.carPath),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.019),
                Text(
                  AppConstants.welcomeToDriveMate,
                  style: AppStyle.welcomeTextStyle,
                ),
                SizedBox(height: SizeConfig.height(context) * 0.019),
                Text(AppConstants.pleaseLogin, style: AppStyle.hintStyle),
                SizedBox(height: SizeConfig.height(context) * 0.049),
                Text(AppConstants.emailAddress, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context) * 0.13,
                  ),
                  child: TextFormFieldWidget(
                    controller:emailController ,
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
                    hintText: AppConstants.enterYourEmail,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.025),
                Text(AppConstants.emailAddress, style: AppStyle.labelStyle),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width(context) * 0.13,
                  ),
                  child: TextFormFieldWidget(
                    controller:passwordController ,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.pleaseEnterYourPassword;
                      } else if (RegExp(
                            AppConstants.passwordValidationPattern,
                          ).hasMatch(value) ==
                          false) {
                        return AppConstants.pleaseEnterValidPassword;
                      }
                      return null;
                    },
                    hintText: AppConstants.enterYourPassword,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.012),
                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context) * 0.18,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: AppStyle.forgetPasswordStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                PrimaryElevatedButtonWidget(
                  formKey: _formKey,
                  buttonText: AppConstants.loginText,
                ),
                SizedBox(height: SizeConfig.height(context) * 0.042),
                DividerWidget(),
                SizedBox(height: SizeConfig.height(context) * 0.042),
                SocialButtonWidget(
                  textButton: AppConstants.continueWithApple,
                  icon: ImageIcon(AssetImage(AppConstants.applePath)),
                  onPressed: () {},
                ),
                SizedBox(height: SizeConfig.height(context) * 0.042),
                SocialButtonWidget(
                  textButton: AppConstants.continueWithGoogle,
                  icon: ImageIcon(AssetImage(AppConstants.googlePath)),
                  onPressed: () {},
                ),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                FooterWidget(
                  onTap: () {
                    // Navigate to signup page
                    Navigator.pushNamed(context, AppConstants.signupPage);
                  },
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
