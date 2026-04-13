import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class DangerZoneWidget extends StatelessWidget {
  const DangerZoneWidget({
    super.key,
    required this.onRemoveVehicle,
  });

  final VoidCallback onRemoveVehicle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRemoveVehicle,
      borderRadius: BorderRadius.circular(AppFontSize.f12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppFontSize.f12),
          border: Border.all(
            color: AppColors.red.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_outlined,
              color: AppColors.red,
              size: 24,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                AppConstants.removeVehicle,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f13,
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}