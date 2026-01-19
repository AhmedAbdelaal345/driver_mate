import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        minimumSize: Size(
          double.infinity,
          SizeConfig.height(context) * 0.07,
        ),
        // padding: EdgeInsets.symmetric(
        //   horizontal:double.infinity,
        //   vertical: SizeConfig.height(context) * 0.02,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.f8),
        ),
      ),
      child: Text(buttonText, style: AppStyle.buttonTextStyle),
    );
  }
}
