import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';

class AvoidMistakesSection extends StatelessWidget {
  const AvoidMistakesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mistakes = [
      "Do not rely only on visual inspection—tires can look fine but be under-inflated.",
      "Do not overinflate—always follow the recommended PSI for your vehicle.",
      "Re-check pressure after adjusting to ensure it is correct.",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffFFF7E6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.orange),
              SizedBox(width: 8),
              Text("Avoid common mistakes", style: AppStyle.titleOfContainer),
            ],
          ),
          const SizedBox(height: 12),

          ...mistakes.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(child: Text(e, style: AppStyle.containerSubtitle)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
