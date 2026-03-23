import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CustomRecommendationBanner extends StatelessWidget {
  const CustomRecommendationBanner({super.key, this.recommdedText});

  final String? recommdedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF9FD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7E3F4)),
      ),
      child: Text(
        recommdedText ?? AppConstants.recommendedBannerText,
        style: const TextStyle(
          color: AppColors.veryDarkBlue,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
