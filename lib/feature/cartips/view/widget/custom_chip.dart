import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, this.hintText});
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        hintText ?? AppConstants.maintenance,
        style: AppStyle.mostText.copyWith(color: AppColors.cyanColor),
      ),
      backgroundColor: AppColors.cyanColor.withValues(alpha: 0.1),
      side: BorderSide(color: AppColors.white.withValues(alpha: 0.1)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
