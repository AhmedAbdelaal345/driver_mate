import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/app_colors.dart';

class WhyItMattersSection extends StatelessWidget {
  const WhyItMattersSection({super.key, this.item});
  final List<String>? item;
  @override
  Widget build(BuildContext context) {
    final List<String> items = item == null || item!.isEmpty
        ? [
            "Proper tire pressure improves vehicle safety and handling",
            "Reduces uneven tire wear and extends tire lifespan",
            "Improves fuel efficiency by up to 3% with correct pressure",
          ]
        : item!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppConstants.whyItMatters, style: AppStyle.titleOfContainer),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.cyanColor,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e,
                        style: AppStyle.containerSubtitle.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
