import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerBar extends StatelessWidget {
  const CustomContainerBar({
    super.key,
    this.numberOfAllVehical,
    this.numOfActive,
    this.numOfInService,
  });
  final String? numberOfAllVehical;
  final String? numOfActive;
  final String? numOfInService;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration:
          BoxDecorationWidget.customBoxDecoration(
            borderRadius: AppFontSize.f24,
          ).copyWith(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [AppColors.blue, AppColors.veryDarkBlue],
            ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.allVehical,
                    style: AppStyle.coursalSubtitleTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    numberOfAllVehical ?? "0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Icon Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppImagePath.carIconPath,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.white,
                    BlendMode.dstIn,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _buildStatusColumn(AppConstants.active, numOfActive ?? "0"),
              const SizedBox(width: 80), // Spacing between stats
              _buildStatusColumn(AppConstants.inService, numOfInService ?? "0"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.coursalSubtitleTextStyle),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
