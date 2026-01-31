import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/auth/view/login_page.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController passwordConfirmController;
  @override
  void initState() {
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    passwordConfirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: LeadingIcon()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04 * SizeConfig.width(context),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0.044 * SizeConfig.height(context)),
                ContainerForIcon(iconPath: AppImagePath.lockIconPath),
                SizedBox(height: 0.044 * SizeConfig.height(context)),

                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    AppConstants.setNewPasswordText,
                    style: AppStyle.labelStyle.copyWith(
                      fontSize: AppFontSize.f20,
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                Text(AppConstants.setNewPasswordHintText),
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    AppConstants.password,
                    style: AppStyle.labelStyle,
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                TextFormFieldWidget(
                  hintText: AppConstants.enterYourPassword,
                  isPassword: true,
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
                  controller: passwordController,
                ),
                SizedBox(height: 0.047 * MediaQuery.of(context).size.height),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    AppConstants.confirmPassword,
                    style: AppStyle.labelStyle,
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                TextFormFieldWidget(
                  hintText: AppConstants.reEnterYourPassword,
                  isPassword: true,
                  controller: passwordConfirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.pleaseEnterYourPassword;
                    } else if (value != passwordController.text) {
                      return AppConstants.doesntMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                PrimaryElevatedButtonWidget(
                  buttonText: AppConstants.updatePassword,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Implement your update password logic here
                      _showSuccessBottomSheet(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.035 * SizeConfig.width(context),
            vertical: 0.1 * SizeConfig.height(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppImagePath.correctMarkPath),
              SizedBox(height: 0.02 * SizeConfig.height(context)),
              Text("Successful", style: AppStyle.labelStyle),
              SizedBox(height: 0.02 * SizeConfig.height(context)),
              Text(
                "Congratulations your password has been changed. Continue to login",
                style: AppStyle.hintStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.02 * SizeConfig.height(context)),
              PrimaryElevatedButtonWidget(
                buttonText: AppConstants.continu,
                onPressed: () => MyNavigation.navigateTo(LoginPage()),
              ),
            ],
          ),
        );
      },
    );
  }
}
