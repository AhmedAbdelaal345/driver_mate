import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/app_colors.dart';

class WhyItMattersSection extends StatelessWidget {
  const WhyItMattersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      "Proper tire pressure improves vehicle safety and handling",
      "Reduces uneven tire wear and extends tire lifespan",
      "Improves fuel efficiency by up to 3% with correct pressure",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Why it matters", style: AppStyle.titleOfContainer),
        const SizedBox(height: 12),
    
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xffF6F7F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle,
                        color: AppColors.cyanColor, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(e, style: AppStyle.containerSubtitle),
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
