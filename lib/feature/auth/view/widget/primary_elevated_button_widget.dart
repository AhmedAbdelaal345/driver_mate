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
    this.padding,
    this.backgroundColor, // <<< add color here
  });

  final GlobalKey<FormState>? formKey;
  final String buttonText;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor; // <<< added


  PrimaryElevatedButtonWidget copyWith({
  Key? key,
  GlobalKey<FormState>? formKey,
  String? buttonText,
  VoidCallback? onPressed,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
}) {
  return PrimaryElevatedButtonWidget(
    key: key ?? this.key,
    formKey: formKey ?? this.formKey,
    buttonText: buttonText ?? this.buttonText,
    onPressed: onPressed ?? this.onPressed,
    padding: padding ?? this.padding,
    backgroundColor: backgroundColor ?? this.backgroundColor,
  );
}


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
  backgroundColor: backgroundColor ?? AppColors.darkBlue,
        minimumSize: Size(
          double.infinity,
          SizeConfig.height(context) * 0.07,
        ),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.f8),
        ),
      ),
      child: Text(buttonText, style: AppStyle.buttonTextStyle),
    );
  }
}
