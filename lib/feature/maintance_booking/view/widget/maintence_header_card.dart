import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/cartips/view/widget/custom_chip.dart';

class MaintenanceHeaderCard extends StatelessWidget {
  const MaintenanceHeaderCard({
    super.key,
    this.hintText,
    this.labelText,
    this.containerText,
  });
  final String? hintText;
  final String? labelText;
  final String? containerText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF6F7F9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomChip(hintText: containerText ?? "AI Maintenance Tip"),
          SizedBox(height: 8),
          Text(
            labelText ?? "Check tire pressure before long trips",
            style: AppStyle.titleOfContainer,
          ),
          SizedBox(height: 6),
          Text(
            hintText ?? "A quick check improves safety and fuel efficiency.",
            style: AppStyle.containerSubtitle,
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.iconGrey),
              SizedBox(width: 4),
              Text("1 min read", style: AppStyle.containerSubtitle),
              SizedBox(width: 10),
              Text("• Updated today", style: AppStyle.containerSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}
