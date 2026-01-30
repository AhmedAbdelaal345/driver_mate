import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:flutter/material.dart';

class QuestionTab extends StatelessWidget {
  const QuestionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CommunityPostHeader(),
        QuestionCard(), // Each card now manages its own "Love" state
        QuestionCard(),
      ],
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  // State variables moved here so they persist
  int counterForLove = 12;
  int counterForComment = 8;
  bool isLoved = false;
  bool thereAreComment = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. User Header
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF1B7F9B),
                child: Text(
                  "AH",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ahmed Hassan",
                    style: AppStyle.socialButtonTextStyle.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "2h ago",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              _buildCategoryTag(),
            ],
          ),
          const SizedBox(height: 16),
          // 2. Content
          Text(
            "Strange clicking sound when turning — what could it be?",
            style: AppStyle.titleOfContainer.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.f16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "My car makes a clicking noise when I turn the steering wheel. It only happens at low speeds.",
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),
          const SizedBox(height: 16),
          Divider(
            indent: 0.1,
            endIndent: 0.9,
            color: AppColors.midGrey,
            radius: BorderRadius.circular(12),
          ),
          // 3. Footer Actions
          Row(
            children: [
              _buildLoveAction(),
              const SizedBox(width: 20),
              _buildCommentAction(),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: AppColors.iconGrey,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                  size: 20,
                  color: AppColors.iconGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        AppConstants.question,
        style: TextStyle(
          color: AppColors.cyanColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoveAction() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLoved = !isLoved;
          isLoved ? counterForLove++ : counterForLove--;
        });
      },
      child: Row(
        children: [
          Icon(
            isLoved ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: isLoved ? Colors.red : AppColors.iconGrey,
          ),
          const SizedBox(width: 6),
          Text(
            counterForLove.toString(),
            style: TextStyle(
              color: AppColors.iconGrey,
              fontSize: AppFontSize.f13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentAction() {
    return GestureDetector(
      onTap: () {
        setState(() {
          thereAreComment = !thereAreComment;
          thereAreComment ? counterForComment++ : counterForComment--;
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.chat_bubble_outline,
            size: 20,
            color: AppColors.iconGrey,
          ),
          const SizedBox(width: 6),
          Text(
            "$counterForComment answers",
            style: TextStyle(
              color: AppColors.iconGrey,
              fontSize: AppFontSize.f13,
            ),
          ),
        ],
      ),
    );
  }
}
