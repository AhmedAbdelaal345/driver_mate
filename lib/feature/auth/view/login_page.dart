import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/textformfield_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  @override
  final GlobalKey _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
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
                    horizontal: SizeConfig.width(context) * 0.06),
                child: TextFormFieldWidget(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return AppConstants.pleaseEnterYourEmail;
                    }else if(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false){
                      return AppConstants.pleaseEnterValidEmail;

                    }
                    return null;
                  },
                  hintText: AppConstants.enterYourEmail,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
