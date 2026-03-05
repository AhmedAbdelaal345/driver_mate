import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class HeroImageSectionWidget extends StatelessWidget {
  const HeroImageSectionWidget({
    super.key,
    required this.imagePath,
    required this.isNew,
  });

  final String imagePath;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.height(context) * 0.28,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.05,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppFontSize.f16),
            image: DecorationImage(
              image: imagePath.startsWith("http")
                  ? NetworkImage(imagePath)
                  : AssetImage(imagePath) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isNew)
          Positioned(
            top: 32,
            right: SizeConfig.width(context) * 0.08,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                AppConstants.newLabel,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f12,
                  color: AppColors.cyanColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
