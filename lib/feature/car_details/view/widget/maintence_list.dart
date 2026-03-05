import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class MaintenanceList extends StatelessWidget {
  const MaintenanceList({super.key});
  final List<Map<String, String>> _maintenanceItems = const [
    {
      'service': AppConstants.oilChange,
      'interval': AppConstants.oilChangeInterval,
    },
    {
      'service': AppConstants.tireRotation,
      'interval': AppConstants.tireRotationInterval,
    },
    {
      'service': AppConstants.brakeInspection,
      'interval': AppConstants.brakeInspectionInterval,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Column(
        children: List.generate(_maintenanceItems.length, (index) {
          final item = _maintenanceItems[index];
          final isLast = index == _maintenanceItems.length - 1;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['service']!,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f12,
                      color: AppColors.textGrey,
                    ),
                  ),
                  Text(
                    item['interval']!,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f12,
                      color: AppColors.cyanColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (!isLast) ...[const SizedBox(height: 16)],
            ],
          );
        }),
      ),
    );
  }
}
