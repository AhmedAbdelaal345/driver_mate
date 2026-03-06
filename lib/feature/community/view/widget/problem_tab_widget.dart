import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/view/widget/footer_icon_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:flutter/material.dart';

class ProblemsTab extends StatelessWidget {
  const ProblemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CommunityPostList(
          filterType: AppConstants.problem,
          showEmptyState: false,
        ),
        // ProblemCard(),
        // ProblemCard(),
      ],
    );
  }
}

class ProblemCard extends StatelessWidget {
  const ProblemCard({super.key, required this.post});
  final CommunityPostModel post;
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
              CircleAvatar(child: Text(post.authorInitials)),
              const SizedBox(width: 12),
              Text(post.authorName),
              const Spacer(),
              _buildTag(AppConstants.problem, Colors.red[50]!, Colors.red),
              const SizedBox(width: 8),
              _buildTag(AppConstants.medium, Colors.orange[50]!, Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          Text(post.title, style: AppStyle.titleOfContainer),
          const SizedBox(height: 8),
          Text(
            post.description,
            style: AppStyle.containerSubtitle.copyWith(
              color: AppColors.midGrey,
              fontSize: AppFontSize.f13,
            ),
          ),
          if (post.image != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                post.image!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ],
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
