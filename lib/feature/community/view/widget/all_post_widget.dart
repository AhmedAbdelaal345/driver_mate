import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/review_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPostsList extends StatelessWidget {
  const AllPostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityPostCubit, CommunityPostState>(
      builder: (context, state) {
        // Loading
        if (state is CommunityPostLoading && state.posts.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: CircularProgressIndicator(color: AppColors.cyanColor),
            ),
          );
        }

        // Error
        if (state is CommunityPostFailure && state.posts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(state.error, style: AppStyle.containerSubtitle),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      context.read<CommunityPostCubit>().loadPosts(),
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: AppColors.cyanColor),
                  ),
                ),
              ],
            ),
          );
        }

        final posts = state.posts;

        if (posts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text('No posts yet', style: AppStyle.containerSubtitle),
            ),
          );
        }

        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (_, index) => _buildCard(posts[index]),
            ),

            // Load-more indicator
            if (state is CommunityPostLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: CircularProgressIndicator(color: AppColors.cyanColor),
              ),

            if (state is CommunityPostLoaded && !state.hasMore)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text('No more posts', style: AppStyle.containerSubtitle),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCard(CommunityFetchPostModel post) {
    // ✅ BUG 5 FIX — correct postType → card mapping
    // 0 = Question, 1 = Tip, 2 = Review, 3 = Marketplace, 4 = Problem
    switch (post.postType) {
      case 0:
        return QuestionCard(post: post);
      case 1:
        return TipCard(post: post);
      case 2:
        return ReviewCard(
          shopName: post.title,
          reviewText: post.content,
          reviewerName: post.authorName,
          timeAgo: post.createdAt.substring(0, 10),
        );
      case 3:
        return MarketplaceCard(post: post);
      case 4:
        return ProblemCard(post: post);
      default:
        return const SizedBox();
    }
  }
}
