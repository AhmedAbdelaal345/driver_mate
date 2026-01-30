import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/footer_icon_widget.dart';
import 'package:flutter/material.dart';

class ProblemsTab extends StatelessWidget {
  const ProblemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [ProblemCard(), ProblemCard()]);
  }
}

class ProblemCard extends StatelessWidget {
  const ProblemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with tags (Medium/High)
          Row(
            children: [
              const CircleAvatar(child: Text("KA")),
              const SizedBox(width: 12),
              const Text("Khaled Ali"),
              const Spacer(),
              _buildTag(AppConstants.problem, Colors.red[50]!, Colors.red),
              const SizedBox(width: 8),
              _buildTag(AppConstants.medium, Colors.orange[50]!, Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "AC not cooling properly in summer heat",
            style: AppStyle.titleOfContainer,
          ),
          const SizedBox(height: 8),
          Text(
            "My AC is struggling in this heat. It blows but not cold enough. Could it be the refrigerant or something else?",
            style: AppStyle.containerSubtitle.copyWith(
              color: AppColors.midGrey,
              fontSize: AppFontSize.f13,
            ),
          ),
          const SizedBox(height: 16),

          // THE AI BUTTON
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.auto_awesome,
                size: 18,
                color: Colors.cyan,
              ),
              label: const Text(
                "Get AI Help",
                style: TextStyle(color: Colors.cyan),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Divider(indent: 0.1, endIndent: 0.9, color: AppColors.grey),
          FooterIconWidget(),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textCol,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
