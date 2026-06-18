import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionTab extends StatelessWidget {
  const QuestionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommunityPostHeader(postType: AppStrings.of(context).question),
        CommunityPostList(
          filterType: AppStrings.of(context).question,
          showEmptyState: true,
        ),
        CommunityPostList(
          filterType: AppStrings.of(context).question,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.post});
  final CommunityPostModel post;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
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

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });
    widget.post.isLiked = _isLiked;
    widget.post.likesCount = _likesCount;
  }

  void _handleSave() {
    setState(() => _isSaved = !_isSaved);
    widget.post.isSaved = _isSaved;

    final item = SavedItemModel(
      title: widget.post.title,
      subtitle: widget.post.description,
      image: widget.post.imageFile?.path ?? widget.post.imageAssetPath ?? '',
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF1B7F9B),
                child: Text(
                  widget.post.authorInitials,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
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
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.post.createdAt.toString().substring(0, 16),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
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
            ),
          ),

          const SizedBox(height: 8),

          // ── Description ───────────────────────────────────────
          Text(
            widget.post.description,
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),

          // ── Post image ────────────────────────────────────────
          if (widget.post.imageFile != null ||
              widget.post.imageAssetPath != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.post.imageFile != null
                  ? Image.file(
                      widget.post.imageFile!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      widget.post.imageAssetPath!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
            ),
          ],

          const SizedBox(height: 16),

          Divider(color: AppColors.midGrey.withValues(alpha: 0.4)),

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
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Comments
              GestureDetector(
                onTap: _handleOpenComments,
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                      color: AppColors.iconGrey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.post.commentsCount} answers',
                      style: TextStyle(
                        color: AppColors.iconGrey,
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
                icon: const Icon(
                  Icons.share_outlined,
                  size: 20,
                  color: AppColors.iconGrey,
                ),
              ),

              // Bookmark
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
    );
  }

  Widget _buildCategoryTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanColor.withValues(alpha: 0.1),
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
}
