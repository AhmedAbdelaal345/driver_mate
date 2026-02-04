import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_post.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPostList extends StatelessWidget {
  const CommunityPostList({
    super.key,
    this.filterType,
    this.showEmptyState = false,
  });

  final String? filterType;
  final bool showEmptyState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityPostCubit, CommunityPostState>(
      builder: (context, state) {
        final posts = _filterPosts(state.posts);

        if (posts.isEmpty && showEmptyState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'No posts yet.',
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.iconGrey,
              ),
            ),
          );
        }

        if (posts.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return _CommunityPostCard(post: posts[index]);
          },
        );
      },
    );
  }

  List<CommunityPostModel> _filterPosts(List<CommunityPostModel> posts) {
    if (filterType == null) return posts;
    return posts.where((p) => p.type == filterType).toList();
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({required this.post});

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
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.cyanColor,
                child: Text(
                  post.authorInitials,
                  style: const TextStyle(color: AppColors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.authorName,
                    style: AppStyle.socialButtonTextStyle.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                  Text(
                    _timeAgo(post.createdAt),
                    style: AppStyle.containerSubtitle.copyWith(
                      color: AppColors.iconGrey,
                      fontSize: AppFontSize.f10,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _TypeTag(type: post.type),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.title,
            style: AppStyle.titleOfContainer.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.f16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post.description,
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class _TypeTag extends StatelessWidget {
  const _TypeTag({required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: AppColors.cyanColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
