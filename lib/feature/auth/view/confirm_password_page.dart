import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/auth/view/set_new_password.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class ConfirmPasswordPage extends StatelessWidget {
  const ConfirmPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: LeadingIcon()),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.04,
        ),
        child: Column(
          children: [
            SizedBox(height: 0.047 * SizeConfig.height(context)),
            ContainerForIcon(iconPath: AppImagePath.peopleIconPath),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                AppConstants.passwordRest,
                style: AppStyle.labelStyle.copyWith(fontSize: AppFontSize.f20),
              ),
            ),
            SizedBox(height: 0.014 * SizeConfig.height(context)),
            Text(AppConstants.confirmPasswordText, style: AppStyle.hintStyle),
            SizedBox(height: 0.041 * SizeConfig.height(context)),
            PrimaryElevatedButtonWidget(
              buttonText: AppConstants.confirm,
              onPressed: () {
                // Implement your confirm password logic here
                MyNavigation.navigateTo(SetNewPasswordPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
