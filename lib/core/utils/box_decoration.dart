import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

abstract class BoxDecorationWidget {
  static BoxDecoration customBoxDecoration({
    double borderRadius = 12.0,
    double borderWidth = 1.0,
  }) {
    return BoxDecoration(
      
      borderRadius: BorderRadius.circular(borderRadius),
      color: AppColors.boarderWhiteColor,
      boxShadow: [
        BoxShadow(
          blurRadius: 2,
          spreadRadius: 0,
          offset: Offset(0, 1),
          color: AppColors.black.withValues(alpha: 0.05),
        ),
      ],
      border: Border.all(
        color: AppColors.boarderWhiteColor,
        width: borderWidth,
      ),
    );
  }
}
