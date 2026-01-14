import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmPasswordPage extends StatelessWidget {
  const ConfirmPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppConstants.arrowBackPath),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.04,
        ),
        child: Column(
          children: [
            SizedBox(height: 0.047 * SizeConfig.height(context)),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                AppConstants.passwordRest,
                style: AppStyle.labelStyle.copyWith(fontSize: AppConstants.f20),
              ),
            ),
            SizedBox(height: 0.014 * SizeConfig.height(context)),
            Text(AppConstants.confirmPasswordText, style: AppStyle.hintStyle),
            SizedBox(height: 0.041 * SizeConfig.height(context)),
            PrimaryElevatedButtonWidget(
              buttonText: AppConstants.confirm,
              onPressed: () {
                // Implement your confirm password logic here
                Navigator.pushNamed(context, AppConstants.setNewPassword);
              },
            ),
          ],
        ),
      ),
    );
  }
}
