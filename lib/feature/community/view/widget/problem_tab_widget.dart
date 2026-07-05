import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
// import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/post_type_tag_widget.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProblemsTab extends StatelessWidget {
  const ProblemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommunityPostHeader(postType: AppConstants.problem),
        CommunityPostList(
          filterType: AppConstants.problem,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class ProblemCard extends StatefulWidget {
  const ProblemCard({super.key, required this.post});
  final CommunityFetchPostModel post;

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
  // late bool _isLiked;
  // late int _likesCount;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    // _isLiked = widget.post.isLiked;
    // _likesCount = widget.post.likesCount;
    _isSaved = widget.post.isSaved ?? false;
  }

  void _handleLike() {
    context.read<CommunityPostCubit>().toggleLike(postId: widget.post.id);
  }

  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
    widget.post.isSaved = _isSaved;

    final item = SavedItemModel(
      title: widget.post.title,
      subtitle: widget.post.content,
      image: widget.post.imageUrls.first,
      type: SavedType.post,
    );
    if (_isSaved) {
      context.read<SavedItemCubit>().addItem(item);
    } else {
      context.read<SavedItemCubit>().removeItem(item);
    }
  }

  void _handleOpenComments() {
    MyNavigation.navigateTo(
      BlocProvider(
        create: (_) => CommunityCommentCubit(),
        child: CommunityCommentPage(
          post: CommunityFetchPostModel(
            authorName: widget.post.authorName,
            commentCount: widget.post.commentCount,
            content: widget.post.content,
            createdAt: widget.post.createdAt.toString(),
            id: widget.post.id,
            imagesCount: 0,
            isLikedByCurrentUser: widget.post.isLikedByCurrentUser,
            likeCount: widget.post.likeCount,
            postType: 4,
            title: widget.post.title,
          ),
        ),
      ),
    );
  }

  void _handleAiHelp() {
    // Placeholder — wire to AI feature when ready
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('AI Help coming soon!'),
        backgroundColor: AppColors.cyanColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: w * 0.05,
                backgroundColor: const Color(0xFF1B7F9B),
                backgroundImage: widget.post.authorImageUrl != null
                    ? NetworkImage(widget.post.authorImageUrl!)
                    : null,
                child: widget.post.authorImageUrl == null
                    ? Text(
                        widget.post.authorInitials,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: w * 0.03,
                        ),
                      )
                    : null,
              ),

              SizedBox(width: w * 0.03),

              // Author + date — MUST be Expanded to prevent overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: AppStyle.socialButtonTextStyle.copyWith(
                        fontSize: AppFontSize.f14,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // ✅
                    ),
                    Text(
                      widget.post.createdAt.length >= 10
                          ? widget.post.createdAt.substring(0, 10)
                          : widget.post.createdAt,
                      style: TextStyle(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // ✅
                    ),
                  ],
                ),
              ),

              SizedBox(width: w * 0.02),

              // Tag — only takes what it needs
              PostTypeTag(label: AppStrings.of(context).problem),
            ],
          ),

          const SizedBox(height: 12),

          // ── Title ─────────────────────────────────────────────
          Text(
            widget.post.title,
            style: AppStyle.titleOfContainer.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          // ── Description ───────────────────────────────────────
          Text(
            widget.post.content,
            style: AppStyle.containerSubtitle.copyWith(
              color: Theme.of(context).iconTheme.color,
              fontSize: AppFontSize.f13,
              height: 1.4,
            ),
          ),

          // ── Image ─────────────────────────────────────────────
          if (widget.post.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.post.imageUrls.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.post.imageUrls[index],
                      width: 280,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        width: 280,
                        height: 180,
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // ── AI Help button ────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton.icon(
              onPressed: _handleAiHelp,
              icon: Icon(
                Icons.auto_awesome,
                size: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
              label: Text(
                'Get AI Help',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Divider(
            color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.4),
          ),

          // ── Footer actions ────────────────────────────────────
          Row(
            children: [
              // Like
              GestureDetector(
                onTap: _handleLike,
                child: Row(
                  children: [
                    Icon(
                      widget.post.isLikedByCurrentUser
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 20,
                      color: widget.post.isLikedByCurrentUser
                          ? Colors.red
                          : Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.post.likeCount.toString(),
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Comments
              GestureDetector(
                onTap: _handleOpenComments,
                child: Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.post.commentCount} answers',
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Share
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),

              // Bookmark
              IconButton(
                onPressed: _handleSave,
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 20,
                  color: _isSaved
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
