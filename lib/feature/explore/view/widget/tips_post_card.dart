import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class TipPostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Tip",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "How to maintain your tires?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            "Checking tire pressure regularly can save fuel and increase tire life...",
            maxLines: 2,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.thumb_up_outlined,
                  color: AppColors.cyanColor,
                ),
                label: Text("Like", style: AppStyle.viewAll),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  color: AppColors.cyanColor,
                ),
                label: Text("Comment", style: AppStyle.viewAll),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
