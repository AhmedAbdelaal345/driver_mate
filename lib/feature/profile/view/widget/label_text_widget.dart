import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Text(title ?? AppConstants.fullName, style: AppStyle.labelStyle);
  }
}
