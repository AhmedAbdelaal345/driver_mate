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

class ProblemsTab extends StatelessWidget {
  const ProblemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [
        CommunityPostHeader(postType: AppConstants.problem),
        CommunityPostList(
          filterType: AppStrings.of(context).problem,
          showEmptyState: true,
        ),
      ],
    );
  }
}
  
class ProblemCard extends StatefulWidget {
  const ProblemCard({super.key, required this.post});
  final CommunityPostModel post;

  @override
  State<ProblemCard> createState() => _ProblemCardState();
}

class _ProblemCardState extends State<ProblemCard> {
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
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  widget.post.authorInitials,
                  style:  TextStyle(color:Theme.of(context).colorScheme.surface, fontSize: 14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: AppStyle.socialButtonTextStyle
                          .copyWith(fontSize: 14,color: Theme.of(context).colorScheme.onSurface),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.post.createdAt.toString().substring(0, 16),
                      style:  TextStyle(
                          color:Theme.of(context).iconTheme.color, fontSize: 11),
                    ),
                  ],
                ),
              ),
              // Tags — use Flexible to prevent overflow
              _buildTag(AppConstants.problem,
                  Colors.red[50]!, Colors.red),
              const SizedBox(width: 6),
              _buildTag(AppConstants.medium,
                  Colors.orange[50]!, Colors.orange),
            ],
          ),

          const SizedBox(height: 12),

          // ── Title ─────────────────────────────────────────────
          Text(widget.post.title, style: AppStyle.titleOfContainer.copyWith(color: Theme.of(context).colorScheme.onSurface)),

          const SizedBox(height: 8),

          // ── Description ───────────────────────────────────────
          Text(
            widget.post.description,
            style: AppStyle.containerSubtitle.copyWith(
              color: Theme.of(context).iconTheme.color,
              fontSize: AppFontSize.f13,
              height: 1.4,
            ),
          ),

          // ── Image ─────────────────────────────────────────────
          if (widget.post.imageFile != null ||
              widget.post.imageAssetPath != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.post.imageFile != null
                  ? Image.file(widget.post.imageFile!,
                      width: double.infinity, height: 180, fit: BoxFit.cover)
                  : Image.asset(widget.post.imageAssetPath!,
                      width: double.infinity, height: 180, fit: BoxFit.cover),
            ),
          ],

          const SizedBox(height: 16),

          // ── AI Help button ────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton.icon(
              onPressed: _handleAiHelp,
              icon:  Icon(Icons.auto_awesome,
                  size: 18, color:Theme.of(context).colorScheme.secondary),
              label:  Text('Get AI Help',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Divider(color: Theme.of(context).iconTheme.color!.withValues(alpha: 0.4)),

          // ── Footer actions ────────────────────────────────────
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
                      color: _isLiked ? Colors.red : Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _likesCount.toString(),
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: AppFontSize.f13),
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
                     Icon(Icons.chat_bubble_outline,
                        size: 20, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.post.commentsCount} answers',
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: AppFontSize.f13),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Share
              IconButton(
                onPressed: () {},
                icon:  Icon(Icons.share_outlined,
                    size: 20, color: Theme.of(context).iconTheme.color),
              ),

              // Bookmark
              IconButton(
                onPressed: _handleSave,
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 20,
                  color: _isSaved ? Theme.of(context).colorScheme.secondary : Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}