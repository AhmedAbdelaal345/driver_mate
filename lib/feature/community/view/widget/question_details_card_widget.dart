import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionDetailsCardWidget extends StatefulWidget {
  const QuestionDetailsCardWidget({super.key, required this.post});

  final CommunityFetchPostModel post;

  @override
  State<QuestionDetailsCardWidget> createState() =>
      _QuestionDetailsCardWidgetState();
}

class _QuestionDetailsCardWidgetState extends State<QuestionDetailsCardWidget> {
  // Local UI copy — synced back to model after each mutation
  late bool _isLiked;
  late int _likesCount;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLikedByCurrentUser;
    _likesCount = widget.post.likeCount;
    _isSaved = widget.post.isSaved ?? false;
  }

  // ── Like — optimistic via CommunityPostCubit ────────────────────
  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });

    context.read<CommunityPostCubit>().toggleLike(postId: widget.post.id);
  }

  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
    widget.post.isSaved = _isSaved;

    final item = SavedItemModel(
      title: widget.post.title,
      subtitle: widget.post.content,
      image: widget.post.firstImageUrl ?? '',
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
        child: CommunityCommentPage(post: widget.post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;

    return BlocListener<CommunityPostCubit, CommunityPostState>(
      listenWhen: (_, current) =>
          current is CommunityLikeToggleSuccess ||
          current is CommunityPostFailure,
      listener: (context, state) {
        if (state is CommunityLikeToggleSuccess) {
          setState(() {
            _isLiked = state.isLiked;
            _likesCount = state
                .numberoflikes; // match actual field name in your state class
          });
        } else if (state is CommunityPostFailure) {
          setState(() {
            _isLiked = widget.post.isLikedByCurrentUser;
            _likesCount = widget.post.likeCount;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
          color: cardColor,
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────────────
            Row(
              children: [
                // Avatar — real photo if available
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFF1B7F9B),
                  backgroundImage: widget.post.authorImageUrl != null
                      ? NetworkImage(widget.post.authorImageUrl!)
                      : null,
                  child: widget.post.authorImageUrl == null
                      ? Text(
                          widget.post.authorInitials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.authorName,
                        style: AppStyle.socialButtonTextStyle.copyWith(
                          fontSize: 15,
                          color: theme.colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.post.createdAt.substring(0, 10),
                        style: TextStyle(
                          color: AppColors.iconGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _CategoryTag(postType: widget.post.postType),
              ],
            ),

            const SizedBox(height: 16),

            // ── Title ───────────────────────────────────────────────────
            Text(
              widget.post.title,
              style: AppStyle.titleOfContainer.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.f16,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            // ── Content ─────────────────────────────────────────────────
            Text(
              widget.post.content,
              style: AppStyle.containerSubtitle.copyWith(
                height: 1.4,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),

            // ── Post image (real network image) ─────────────────────────
            if (widget.post.firstImageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.post.firstImageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          width: double.infinity,
                          height: 200,
                          color: theme.colorScheme.surface,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.cyanColor,
                            ),
                          ),
                        ),
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    height: 200,
                    color: theme.colorScheme.surface,
                    child: const Icon(
                      Icons.broken_image_outlined,
                      color: AppColors.iconGrey,
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            Divider(color: theme.colorScheme.outline.withValues(alpha: 0.3)),

            // ── Actions ─────────────────────────────────────────────────
            Row(
              children: [
                // Like
                GestureDetector(
                  onTap: _handleLike,
                  child: Row(
                    children: [
                      Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: _isLiked ? Colors.red : AppColors.iconGrey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _likesCount.toString(),
                        style: TextStyle(
                          color: AppColors.iconGrey,
                          fontSize: AppFontSize.f13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Comments — live count from cubit
                GestureDetector(
                  onTap: _handleOpenComments,
                  child:
                      BlocBuilder<CommunityCommentCubit, CommunityCommentState>(
                        builder: (context, commentState) {
                          final count = commentState is CommunityCommentLoaded
                              ? commentState.comments.length
                              : widget.post.commentCount;
                          return Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline,
                                size: 20,
                                color: AppColors.iconGrey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$count answers',
                                style: TextStyle(
                                  color: AppColors.iconGrey,
                                  fontSize: AppFontSize.f13,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 20,
                    color: AppColors.iconGrey,
                  ),
                ),

                IconButton(
                  onPressed: _handleSave,
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: _isSaved ? AppColors.cyanColor : AppColors.iconGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Category tag — derived from postType int ──────────────────────────────
class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.postType});
  final int postType;

  static const _labels = {
    0: 'Question',
    1: 'Tip',
    2: 'Review',
    3: 'Marketplace',
    4: 'Problem',
  };

  @override
  Widget build(BuildContext context) {
    final label = _labels[postType] ?? 'Post';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.cyanColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
