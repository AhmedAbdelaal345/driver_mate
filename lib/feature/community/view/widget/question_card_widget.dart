import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
// import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
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

class QuestionTab extends StatelessWidget {
  const QuestionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommunityPostHeader(postType: 0),
        CommunityPostList(
          filterType: AppConstants.question,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.post});
  final CommunityFetchPostModel post;

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
    _isLiked = widget.post.isLikedByCurrentUser;
    _likesCount = widget.post.likeCount;
    _isSaved = widget.post.isSaved ?? false;
  }

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
    final w = SizeConfig.width(context);
    final h = SizeConfig.height(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.008),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: AppFontSize.f14,
      ).copyWith(color: cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────────
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
              PostTypeTag(label: AppConstants.question),
            ],
          ),

          SizedBox(height: h * 0.015),

          // ── Title ─────────────────────────────────────────────────
          Text(
            widget.post.title,
            style: AppStyle.titleOfContainer.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.f15,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // ✅
          ),

          SizedBox(height: h * 0.008),

          // ── Content ───────────────────────────────────────────────
          Text(
            widget.post.content,
            style: AppStyle.containerSubtitle.copyWith(
              height: 1.4,
              color: theme.textTheme.bodyMedium?.color,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis, // ✅
          ),

          // ── Image ─────────────────────────────────────────────────
          if (widget.post.imageUrls.isNotEmpty) ...[
            SizedBox(height: h * 0.012),
            SizedBox(
              height: h * 0.22,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.post.imageUrls.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(AppFontSize.f12),
                  child: SizedBox(
                    width: w * 0.75,
                    height: h * 0.22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.post.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: SizeConfig.width(context) * 0.01);
                },
              ),
            ),
          ],

          SizedBox(height: h * 0.015),

          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            height: 1,
          ),

          SizedBox(height: h * 0.005),

          // ── Actions ───────────────────────────────────────────────
          Row(
            children: [
              // Like
              GestureDetector(
                onTap: _handleLike,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      size: w * 0.05,
                      color: _isLiked ? Colors.red : AppColors.iconGrey,
                    ),
                    SizedBox(width: w * 0.01),
                    Text(
                      '$_likesCount',
                      style: TextStyle(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: w * 0.04),

              // Comments
              GestureDetector(
                onTap: _handleOpenComments,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: w * 0.05,
                      color: AppColors.iconGrey,
                    ),
                    SizedBox(width: w * 0.01),
                    Text(
                      '${widget.post.commentCount} answers',
                      style: TextStyle(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Share
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.share_outlined,
                  size: w * 0.05,
                  color: AppColors.iconGrey,
                ),
              ),

              SizedBox(width: w * 0.03),

              // Bookmark
              GestureDetector(
                onTap: _handleSave,
                child: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: w * 0.05,
                  color: _isSaved ? AppColors.cyanColor : AppColors.iconGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
