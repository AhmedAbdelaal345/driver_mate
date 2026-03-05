import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class AvailableServicesChips extends StatelessWidget {
  const AvailableServicesChips({super.key, this.services});
  final List<String>? services;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: services!.map((service) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.containerGrey.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.containerGrey),
          ),
          child: Text(
            service,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f11,
              color: AppColors.textGrey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
