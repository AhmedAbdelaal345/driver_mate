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
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CommunityPostHeader(postType: AppStrings.of(context).tips),
        CommunityPostList(filterType: AppStrings.of(context).tips, showEmptyState: true),
      ],
    );
  }
}

class TipCard extends StatefulWidget {
  const TipCard({super.key, required this.post});
  final CommunityPostModel post;

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  late bool _isSaved;
  late int _savedCount;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.post.isSaved;
    _savedCount = widget.post.likesCount; // reuse likesCount as save count
  }

  void _handleSave() {
    setState(() {
      _isSaved = !_isSaved;
      _savedCount += _isSaved ? 1 : -1;
    });
    widget.post.isSaved = _isSaved;
    widget.post.likesCount = _savedCount;

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
              const CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFE0F2F1),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.teal,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maintenance Tip',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.post.authorName,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Text(
                widget.post.createdAt.toString().substring(0, 16),
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
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
            widget.post.description,
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),

          // ── Image ─────────────────────────────────────────────
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

          // ── Save banner ───────────────────────────────────────
          GestureDetector(
            onTap: _handleSave,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
                color: AppColors.cyanColor.withValues(alpha: 0.08),
              ),
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
                      '${widget.post.commentsCount} comments',
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
