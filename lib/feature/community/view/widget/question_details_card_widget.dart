import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionDetailsCardWidget extends StatefulWidget {
  const QuestionDetailsCardWidget({super.key, required this.post});

  final CommunityPostModel post;

  @override
  State<QuestionDetailsCardWidget> createState() =>
      _QuestionDetailsCardWidgetState();
}

class _QuestionDetailsCardWidgetState extends State<QuestionDetailsCardWidget> {
  // Local UI state — mirrors model values as initial values,
  // then owned by this widget so setState works correctly
  late bool _isLiked;
  late int _likesCount;
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likesCount = widget.post.likesCount;
    _isSaved = widget.post.isSaved;
  }

  // ── Like ──────────────────────────────────────────────────────────────────
  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });

    // Keep model in sync for when this widget is rebuilt from parent
    widget.post.isLiked = _isLiked;
    widget.post.likesCount = _likesCount;
  }

  // ── Bookmark ──────────────────────────────────────────────────────────────
  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
    widget.post.isSaved = _isSaved;

    final savedItem = SavedItemModel(
      title: widget.post.title,
      subtitle: widget.post.description,
      // prefer file path, fall back to asset path, then empty
      image: widget.post.imageFile?.path ?? widget.post.imageAssetPath ?? '',
      type: SavedType.post,
    );

    if (_isSaved) {
      context.read<SavedItemCubit>().addItem(savedItem);
    } else {
      context.read<SavedItemCubit>().removeItem(savedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  widget.post.authorInitials,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.authorName,
                    style: AppStyle.socialButtonTextStyle.copyWith(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    widget.post.createdAt.toString().substring(0, 16),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildCategoryTag(),
            ],
          ),

          const SizedBox(height: 16),

          // ── Title ─────────────────────────────────────────────
          Text(
            widget.post.title,
            style: AppStyle.titleOfContainer.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.f16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),

          const SizedBox(height: 8),

          // ── Description ───────────────────────────────────────
          Text(
            widget.post.description,
            style: AppStyle.containerSubtitle.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              height: 1.4,
            ),
          ),

          // ── Image ─────────────────────────────────────────────
          if (widget.post.imageAssetPath != null ||
              widget.post.imageFile != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.post.imageFile != null
                  ? Image.file(
                      // real file from gallery/camera
                      widget.post.imageFile!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      // bundled asset for seed data
                      widget.post.imageAssetPath!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
            ),
          ],
          const SizedBox(height: 16),

          Divider(
            color: Theme.of(context).dividerColor,
            radius: BorderRadius.circular(12),
          ),

          // ── Actions ───────────────────────────────────────────
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
                        color: Theme.of(context).textTheme.bodySmall?.color,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Comment count — navigates to comments page
              BlocBuilder<CommunityCommentCubit, CommunityCommentState>(
                builder: (context, state) {
                  // Derive count from loaded state, fall back to model value
                  final count = state is CommunityCommentLoaded
                      ? state.comments.length
                      : widget.post.commentsCount;

                  return Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$count answers',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: AppFontSize.f13,
                        ),
                      ),
                    ],
                  );
                },
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

  Widget _buildCategoryTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child:  Text(
        AppConstants.question,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
