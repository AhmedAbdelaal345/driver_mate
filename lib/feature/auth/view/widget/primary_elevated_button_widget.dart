import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart' show AppStyle;
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButtonWidget extends StatelessWidget {
  const PrimaryElevatedButtonWidget({
    super.key,
     this.formKey,
    required this.buttonText,
    required this.onPressed,
  });
  final GlobalKey ?formKey;
  final String buttonText;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.01,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.darkBlue,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.3,
            vertical: SizeConfig.height(context) * 0.02,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.f8),
          ),
        ),
        child: Text(buttonText, style: AppStyle.buttonTextStyle),
      ),
    );
  }
}
