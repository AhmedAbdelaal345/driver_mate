import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:flutter/material.dart';

class FloatActionButtonWidget extends StatelessWidget {
  const FloatActionButtonWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.mic, color: AppColors.white),
      color: AppColors.cyanColor,
      style: ButtonStyle(
        iconSize: WidgetStatePropertyAll(AppFontSize.f48),
        shadowColor: WidgetStatePropertyAll(
          AppColors.black.withValues(alpha: 0.1),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(999),
          ),
        ),
      ),
    );
  }
}
