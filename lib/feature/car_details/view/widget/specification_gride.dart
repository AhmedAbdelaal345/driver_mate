import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class SpecificationsGrid extends StatelessWidget {
   const SpecificationsGrid({super.key});
  @override
  Widget build(BuildContext context) {
     final List<Map<String, String>> _specifications =  [
    {'label': AppStrings.of(context).engine, 'value': AppConstants.engineValue},
    {
      'label': AppStrings.of(context).transmission,
      'value': AppConstants.transmissionValue,
    },
    {'label': AppStrings.of(context).fuelType, 'value': AppConstants.fuelTypeValue},
    {'label': AppStrings.of(context).drivetrain, 'value': AppConstants.drivetrainValue},
    {'label': AppStrings.of(context).seating, 'value': AppConstants.seatingValue},
    {'label': AppStrings.of(context).mpg, 'value': AppConstants.mpgValue},
  ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f12,
      ),
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
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Text(
                    spec['value']!,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
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
