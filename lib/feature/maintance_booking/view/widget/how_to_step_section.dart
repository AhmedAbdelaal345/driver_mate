import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/app_colors.dart';

class HowToStepsSection extends StatelessWidget {
  const HowToStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Check pressure when tires are cold (before driving or 3+ hours after).",
      "Use the recommended PSI from the door sticker or owner manual.",
      "Measure all tires, including the spare if available.",
      "Adjust pressure and re-check to ensure accuracy.",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("How to do it", style: AppStyle.titleOfContainer),
        const SizedBox(height: 12),
    
        ...steps.asMap().entries.map(
          (e) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xffF6F7F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.veryDarkBlue,
                  child: Text("${e.key + 1}",
                      style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(e.value, style: AppStyle.containerSubtitle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
