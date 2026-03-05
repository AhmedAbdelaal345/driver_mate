import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart' show AppImagePath;
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class HeroImageSection extends StatelessWidget {
  const HeroImageSection({super.key, this.imagePath, this.date});
  final String? imagePath;
  final DateTime? date;
  @override
  Widget build(BuildContext context) {
    String state() {
      if (DateTime.now().isAfter(date ?? DateTime.now())) {
        return AppConstants.closed;
      } else {
        return AppConstants.openNow;
      }
    }

    return Stack(
      children: [
        // Hero Image
        Container(
          height: SizeConfig.height(context) * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath ?? AppImagePath.bmwCarImagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Open Now Badge
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: state() == AppConstants.closed
                  ? AppColors.red.withValues(alpha: 0.1)
                  : AppColors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              state(),
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
