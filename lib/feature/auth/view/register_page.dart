import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/divider_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/footer_register_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool isAgreed = false;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            height: SizeConfig.height(context) * 0.024,
            width: SizeConfig.width(context) * 0.024,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
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
                  controller: nameController,
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
                    return null;
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
                SizedBox(height: 0.018 * SizeConfig.height(context)),
                Row(
                  children: [
                    Checkbox(
                      value: isAgreed,
                      onChanged: (value) {
            setState(() {
                        isAgreed = value!;
              
            });
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
                  buttonText: AppConstants.signup,
                  onPressed: () {
                    final FormState form = _formKey.currentState as FormState;
                    if (form.validate()) {
                      // Proceed with registration logic
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
