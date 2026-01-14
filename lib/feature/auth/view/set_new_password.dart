import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
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
      appBar: AppBar(leading: SvgPicture.asset(AppConstants.arrowBackPath)),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 0.04* SizeConfig.width(context)),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 0.044*SizeConfig.height(context),),
                Align(alignment: AlignmentGeometry.centerLeft,child: Text(AppConstants.setNewPasswordText,style: AppStyle.labelStyle.copyWith(fontSize: AppConstants.f20),)),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                Text(AppConstants.setNewPasswordHintText),
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                Align(alignment: AlignmentGeometry.centerLeft,child: Text(AppConstants.password, style: AppStyle.labelStyle)),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                TextFormFieldWidget(
                  hintText: AppConstants.enterYourPassword,
                  isPassword: true,
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
                  controller: passwordController,
                ),
                SizedBox(height: 0.047 * MediaQuery.of(context).size.height),
                Align(alignment: AlignmentGeometry.centerLeft,child: Text(AppConstants.confirmPassword, style: AppStyle.labelStyle)),
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
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      // Implement your update password logic here
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.035 * SizeConfig.width(context),
                              vertical: 0.1 * SizeConfig.height(context),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(AppConstants.correctMarkPath),
                                  SizedBox(
                                    height: 0.02 * SizeConfig.height(context),
                                  ),
                                  Center(
                                    child: Text(
                                      "Successful",
                                      style: AppStyle.labelStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.02 * SizeConfig.height(context),
                                  ),
                                  Center(
                                    child: Text(
                                      "Congratulations your password has been changed.Continue to login",
                                      style: AppStyle.hintStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.02 * SizeConfig.height(context),
                                  ),
                                  PrimaryElevatedButtonWidget(
                                    buttonText: AppConstants.continu,
                                    onPressed: () => Navigator.popAndPushNamed(
                                      context,
                                      AppConstants.loginPage,
                                    ),
                                  ),
                                
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
}
