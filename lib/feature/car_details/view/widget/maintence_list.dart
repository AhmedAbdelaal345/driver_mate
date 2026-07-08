import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class MaintenanceList extends StatelessWidget {
  const MaintenanceList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> maintenanceItems = [
      {
        'service': AppStrings.of(context).oilChangeDue,
        'interval': AppStrings.of(context).oilChangeInterval,
      },
      {
        'service': AppStrings.of(context).tireRotation,
        'interval': AppStrings.of(context).tireRotationInterval,
      },
      {
        'service': AppStrings.of(context).brakeInspection,
        'interval': AppStrings.of(context).brakeInspectionInterval,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: AppFontSize.f12,
      ),
      child: Column(
        children: List.generate(maintenanceItems.length, (index) {
          final item = maintenanceItems[index];
          final isLast = index == maintenanceItems.length - 1;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['service']!,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Text(
                    item['interval']!,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f12,
                      color: Theme.of(context).primaryColor,
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
