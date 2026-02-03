import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_post_header.dart';
import 'package:flutter/material.dart';

// feature/community/view/widget/market_place_widget.dart
class MarketplaceTab extends StatelessWidget {
  const MarketplaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return ListView(
      padding: const EdgeInsets.only(bottom: 100), // Space for FAB
      children: [
        MarketplacePostHeader(
          controller: controller,
        ), // The "Ask a question" style header
        const MarketplaceCard(),
      ],
    );
  }
}

class MarketplaceCard extends StatelessWidget {
  const MarketplaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info & Tag
          Row(
            children: [
              const CircleAvatar(radius: 18, child: Text("MA")),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mohamed Ali",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "1h ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              _buildPartTag(),
            ],
          ),
          const SizedBox(height: 16),

          // Title & Price
          Text(
            "Brake Pads for Toyota Camry",
            style: AppStyle.titleOfContainer.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                "\$45",
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
              Text(
                " New Cairo",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            "Original brake pads, used for 6 months only. In excellent condition. Fits 2018-2022 models.",
            style: AppStyle.containerSubtitle,
          ),
          const SizedBox(height: 16),

          // Image Gallery (Placeholders)
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Container(
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_outlined, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons Row
          const Divider(),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildIconBtn(Icons.bookmark_border, AppConstants.save, () {}),
              _buildIconBtn(
                Icons.chat_bubble_outline,
                AppConstants.message,
                () {},
              ),
              _buildIconBtn(Icons.phone_outlined, AppConstants.call, () {}),
              _buildIconBtn(Icons.share_outlined, AppConstants.share, () {}),
            ],
          ),
          const SizedBox(height: 12),

          // View Details Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "View Details",
                style: TextStyle(color: Colors.cyan),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.cyan.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "Part",
        style: TextStyle(
          color: Colors.cyan,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.iconGrey),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
