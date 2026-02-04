// feature/community/view/widget/tips_tab_widget.dart

import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/footer_icon_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:flutter/material.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CommunityPostHeader(),
        CommunityPostList(filterType: AppConstants.tips, showEmptyState: false),
        TipCard(),
        TipCard(),
      ],
    );
  }
}

class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE0F2F1),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.teal,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Maintenance Tip",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Icon(Icons.more_horiz, color: Colors.grey[400]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Best oil change interval for city driving",
            style: AppStyle.titleOfContainer.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "I recommend changing oil every 5,000 km if you drive mostly in heavy traffic to maintain engine health.",
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
              color: AppColors.cyanColor.withValues(alpha: 0.1),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark,
                  size: 20,
                  color: AppColors.cyanColor,
                ),
                const SizedBox(width: 6),
                const Text(
                  "156 people saved this",
                  style: TextStyle(
                    color: AppColors.cyanColor,
                    fontSize: AppFontSize.f13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          const Divider(),

          FooterIconWidget(),
        ],
      ),
    );
  }
}
