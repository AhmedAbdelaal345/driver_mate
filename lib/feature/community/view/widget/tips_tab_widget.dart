import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
// import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/post_type_tag_widget.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommunityPostHeader(postType: 1),
        CommunityPostList(filterType: AppConstants.tips, showEmptyState: true),
      ],
    );
  }
}

class TipCard extends StatefulWidget {
  const TipCard({super.key, required this.post});
  final CommunityFetchPostModel post;

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  late bool _isSaved;
  late int _savedCount;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.post.isSaved ?? false;
    _savedCount = widget.post.likeCount ?? 0; // reuse likesCount as save count
  }

  void _handleSave() {
    setState(() {
      _isSaved = !_isSaved;
      _savedCount += _isSaved ? 1 : -1;
    });
    widget.post.isSaved = _isSaved;

    final item = SavedItemModel(
      title: widget.post.title,
      subtitle: widget.post.content,
      image: widget.post.imageUrls.first ?? '',
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
            id: widget.post.id,
            title: widget.post.title,
            content: widget.post.content,
            postType: 1,
            authorName: widget.post.authorName,
            createdAt: widget.post.createdAt.toString(),
            imagesCount: 0,
            likeCount: widget.post.likeCount,
            commentCount: widget.post.commentCount,
            isLikedByCurrentUser: widget.post.isLikedByCurrentUser,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig.width(context);
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
              PostTypeTag(label: AppStrings.of(context).tips),
            ],
          ),

          const SizedBox(height: 12),

          // ── Title ─────────────────────────────────────────────
          Text(
            widget.post.title,
            style: AppStyle.titleOfContainer.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // ── Description ───────────────────────────────────────
          Text(
            widget.post.content,
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),

          // ── Image ──────────────────────────────────────────
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

          // ── Save banner ───────────────────────────────────────
          GestureDetector(
            onTap: _handleSave,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecorationWidget.customBoxDecoration(
                context,
              ).copyWith(color: AppColors.cyanColor.withValues(alpha: 0.08)),
              child: Row(
                children: [
                  Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: AppColors.cyanColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$_savedCount people saved this',
                    style: const TextStyle(
                      color: AppColors.cyanColor,
                      fontSize: AppFontSize.f13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 24),

          // ── Footer ────────────────────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: _handleOpenComments,
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 18,
                      color: AppColors.iconGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.post.commentCount} comments',
                      style: TextStyle(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  size: 18,
                  color: AppColors.iconGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
