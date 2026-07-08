import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
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

class CommunityPostList extends StatelessWidget {
  const CommunityPostList({
    super.key,
    this.filterType,
    this.showEmptyState = true,
  });

  /// Pass one of: AppConstants.question / tips / review / marketPlace / problem
  /// Leave null to show ALL posts (each rendered with its own card).
  final String? filterType;
  final bool showEmptyState;

  // ── Map filterType string → backend postType integer ──────────────────────
  // These integers come directly from what the backend stores.
  // If a Tips post shows under the wrong filter, swap the integer here.
  static const Map<String, int> _postTypeByFilter = {
    AppConstants.question: 0,
    AppConstants.tips: 1,
    AppConstants.review: 2,
    AppConstants.marketPlace: 3,
    AppConstants.problem: 4,
  };

  // ── Build the correct card for a given filterType ─────────────────────────
  // Each card type has its own design — no generic card used here.
  Widget _buildCard(BuildContext context, CommunityFetchPostModel post) {
    switch (filterType) {
      case AppConstants.question:
        return QuestionCard(post: post);

      case AppConstants.tips:
        return TipCard(post: post);

      case AppConstants.review:
        return ReviewCard(
          shopName: post.title,
          reviewText: post.content,
          reviewerName: post.authorName,
          reviewerInitials: post.authorInitials,
          timeAgo: post.createdAt.length >= 10
              ? post.createdAt.substring(0, 10)
              : post.createdAt,
          location: "Cairo",
          post: post,
        );

      case AppConstants.marketPlace:
        return MarketplaceCard(post: post);

      case AppConstants.problem:
        return ProblemCard(post: post);

      default:
        // null filterType → show all posts, each with its own card
        return _buildCardByPostType(post);
    }
  }

  // ── Fallback for "All" tab — derive card from postType integer ────────────
  Widget _buildCardByPostType(CommunityFetchPostModel post) {
    switch (post.postType) {
      case 0:
        return QuestionCard(post: post);
      case 1:
        return TipCard(post: post);
      case 2:
        return ReviewCard(
          post: post,
          location: "Cairo",
          rating: 4,
          shopName: post.title,
          reviewText: post.content,
          reviewerName: post.authorName,
          reviewerInitials: post.authorInitials,
          timeAgo: post.createdAt.length >= 10
              ? post.createdAt.substring(0, 10)
              : post.createdAt,
        );
      case 3:
        return MarketplaceCard(post: post);
      case 4:
        return ProblemCard(post: post);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.height(context);
    final w = SizeConfig.width(context);

    return BlocBuilder<CommunityPostCubit, CommunityPostState>(
      builder: (context, state) {
        // ── Loading ──────────────────────────────────────────────────
        if (state is CommunityPostLoading && state.posts.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: h * 0.04),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.cyanColor),
            ),
          );
        }

        // ── Error ────────────────────────────────────────────────────
        if (state is CommunityPostFailure && state.posts.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(w * 0.06),
            child: Column(
              children: [
                Text(
                  state.error,
                  style: AppStyle.containerSubtitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: h * 0.015),
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

        // ── Filter posts ─────────────────────────────────────────────
        // When filterType is set, only show posts matching that postType int.
        // When null, show everything.
        final targetType = filterType != null
            ? _postTypeByFilter[filterType]
            : null;

        final filtered = targetType == null
            ? state.posts
            : state.posts.where((p) => p.postType == targetType).toList();

        // ── Empty ────────────────────────────────────────────────────
        if (filtered.isEmpty) {
          if (!showEmptyState) return const SizedBox();
          return Padding(
            padding: EdgeInsets.all(w * 0.06),
            child: Center(
              child: Text(
                'No posts yet',
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          );
        }

        // ── List ─────────────────────────────────────────────────────
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              itemBuilder: (_, index) => _buildCard(context, filtered[index]),
            ),

            // Load-more indicator
            if (state is CommunityPostLoadingMore)
              Padding(
                padding: EdgeInsets.symmetric(vertical: h * 0.02),
                child: const CircularProgressIndicator(
                  color: AppColors.cyanColor,
                ),
              ),

            // End of list label
            if (state is CommunityPostLoaded &&
                !state.hasMore &&
                filtered.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: h * 0.015),
                child: Text(
                  'No more posts',
                  style: AppStyle.containerSubtitle.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
