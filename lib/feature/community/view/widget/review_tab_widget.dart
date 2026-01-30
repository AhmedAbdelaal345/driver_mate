import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/community_filter_row.dart';
import 'package:driver_mate/feature/community/view/widget/review_header_widget.dart';
import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        // 1. Dark "Write a Review" Card
        ReviewHeader(),

        // 2. Secondary Filters
        CommunityFilterRow(
          filters: ["All ratings", "5.0 ★", "4.0 ★+", "Nearby", "Most Recent"],
        ),

        SizedBox(height: 8),

        // 3. The Feed
        ReviewCard(),
        ReviewCard(),
        ReviewCard(),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Auto Care Center", style: AppStyle.titleOfContainer),
          const SizedBox(height: 6),
          Row(
            children:
                List.generate(
                    5,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                  )
                  ..add(const SizedBox(width: 8))
                  ..add(
                    const Text(
                      "5.0",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          Text(
            "Excellent service! Quick oil change and thorough inspection. Staff was very professional and...",
            style: AppStyle.containerSubtitle,
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.grey),

          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.cyanColor,

                child: Text(
                  "AH",
                  style: TextStyle(fontSize: 10, color: AppColors.white),
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ahmed Hassan",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "2 days ago",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Colors.grey[600],
              ),
              Text(
                " Downtown Plaza",
                style: TextStyle(color: Colors.grey[600], fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
