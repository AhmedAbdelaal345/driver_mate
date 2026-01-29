import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CustomRecommendationBanner extends StatelessWidget {
  const CustomRecommendationBanner({super.key, this.recommdedText});
  final String? recommdedText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.powderBlueColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.smoothcyanColor),
      ),
      child: Row(
        children: [
          Icon(Icons.psychology, color: AppColors.cyanColor, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommdedText ?? AppConstants.recommendedBannerText,
              style: const TextStyle(
                color: AppColors.cyanColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
