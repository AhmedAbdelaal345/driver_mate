import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:flutter/material.dart';

class FloatActionButtonWidget extends StatelessWidget {
  const FloatActionButtonWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Ensure the button has a specific size
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: AppColors.cyanColor, // Background color
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.mic,
            color: AppColors.white,
            size: AppFontSize.f32, // Adjusted size to fit well in a 70px circle
          ),
        ),
      ),
    );
  }
}