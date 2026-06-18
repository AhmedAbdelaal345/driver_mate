import 'dart:io';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/view/widget/custom_car_container.dart';
import 'package:flutter/material.dart';

class VehicleDetailCard extends StatelessWidget {
  const VehicleDetailCard({super.key, required this.car});
  final VechicleModel car;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;
    final mutedText = theme.textTheme.bodySmall?.color ?? AppColors.iconGrey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f24,
      ).copyWith(color: cardColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          car.image != null
              ? CustomCarContainer(image: car.image!)
              : const CustomCarContainer(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.brand,
                  style: AppStyle.boldTextStyle.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  '${car.model} • ${car.year}',
                  style: AppStyle.hintStyle.copyWith(color: mutedText),
                ),
                const SizedBox(height: 8),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: car.status == VehicleStatus.active
                        ? AppColors.green.withValues(alpha: 0.1)
                        : car.status == VehicleStatus.inactive
                            ? AppColors.grey.withValues(alpha: 0.1)
                            : AppColors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    car.status == VehicleStatus.active
                        ? AppStrings.of(context).active
                        : car.status == VehicleStatus.inactive
                            ? AppStrings.of(context).inactive
                            : AppStrings.of(context).inService,
                    style: TextStyle(
                      color: car.status == VehicleStatus.active
                          ? AppColors.green
                          : car.status == VehicleStatus.inactive
                              ? AppColors.iconGrey
                              : AppColors.orange,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildServiceInfo(
                  Icons.calendar_today,
                  'Mileage: ${car.millAge}',
                  color: mutedText,
                ),
                const SizedBox(height: 4),
                _buildServiceInfo(
                  Icons.confirmation_number,
                  'Plate: ${car.plateNumber}',
                  color: AppColors.cyanColor,
                  isNext: true,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: mutedText),
        ],
      ),
    );
  }

  Widget _buildServiceInfo(IconData icon, String text,
      {Color? color, bool isNext = false}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}