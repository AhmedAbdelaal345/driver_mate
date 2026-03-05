import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class MockMapView extends StatelessWidget {
  const MockMapView({
    super.key,
    required this.onOpenMaps,
    required this.isLoading,
  });

  final VoidCallback onOpenMaps;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF16C9C9),
        borderRadius: BorderRadius.circular(AppFontSize.f12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_pin, size: 64, color: AppColors.red),
            const SizedBox(height: 6),
            Text(
              AppConstants.mapPreview,
              style: AppStyle.boldSmallText.copyWith(
                color: AppColors.white,
                fontSize: AppFontSize.f12,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: isLoading ? null : onOpenMaps,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.white.withValues(alpha: 0.7),
                foregroundColor: AppColors.cyanColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: Icon(
                Icons.map_outlined,
                size: 16,
                color: isLoading ? AppColors.iconGrey : AppColors.cyanColor,
              ),
              label: Text(
                isLoading ? AppConstants.openingMaps : AppConstants.openInMaps,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f11,
                  color: isLoading ? AppColors.iconGrey : AppColors.cyanColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
