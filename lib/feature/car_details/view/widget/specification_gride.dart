import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class SpecificationsGrid extends StatelessWidget {
  final List<Map<String, String>> _specifications = const [
    {'label': AppConstants.engine, 'value': AppConstants.engineValue},
    {
      'label': AppConstants.transmission,
      'value': AppConstants.transmissionValue,
    },
    {'label': AppConstants.fuelType, 'value': AppConstants.fuelTypeValue},
    {'label': AppConstants.drivetrain, 'value': AppConstants.drivetrainValue},
    {'label': AppConstants.seating, 'value': AppConstants.seatingValue},
    {'label': AppConstants.mpg, 'value': AppConstants.mpgValue},
  ];
  const SpecificationsGrid({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Column(
        children: List.generate(_specifications.length, (index) {
          final spec = _specifications[index];
          final isLast = index == _specifications.length - 1;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    spec['label']!,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f12,
                      color: AppColors.iconGrey,
                    ),
                  ),
                  Text(
                    spec['value']!,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f12,
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
