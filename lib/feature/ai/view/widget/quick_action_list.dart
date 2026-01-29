import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/ai/view/widget/quick_action_widget.dart';
import 'package:flutter/material.dart';

class QuickActionList extends StatelessWidget {
  const QuickActionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "QUICK ACTIONS",
          style: AppStyle.titleOfContainer.copyWith(
            fontSize: 13,
            color: AppColors.textGrey,
          ),
        ),
        const SizedBox(height: 12),

        // START SOUND SCAN
        QuickActionItemWidget(
          icon: AppImagePath.micIconPath,
          title: "Start Sound Scan",
          subtitle: "AI-powered audio diagnosis",
          isHighlighted: true,
          gradient: const LinearGradient(
            colors: [Color(0xff017A9B), Color(0xff06B4CF)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          iconColor: Colors.white,
          onTap: () {},
        ),

        const SizedBox(height: 12),

        // BOOK MAINTENANCE
        QuickActionItemWidget(
          icon: AppImagePath.repairIconPath,
          title: "Book Maintenance",
          subtitle: "Find and schedule service",
          onTap: () {},
        ),

        const SizedBox(height: 12),

        // EMERGENCY HELP
        QuickActionItemWidget(
          icon: AppImagePath.phoneIconPath,
          title: "Emergency Help",
          subtitle: "Get instant support",
          borderColor: AppColors.red,
          iconColor: AppColors.red,
          onTap: () {},
        ),
      ],
    );
  }
}
