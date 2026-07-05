import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
// import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/post_type_tag_widget.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketplaceTab extends StatelessWidget {
  const MarketplaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        MarketplacePostHeader(),
        CommunityPostList(
          filterType: AppConstants.marketPlace,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class MarketplaceCard extends StatefulWidget {
  const MarketplaceCard({super.key, required this.post});
  final CommunityFetchPostModel post;

  @override
  State<MarketplaceCard> createState() => _MarketplaceCardState();
}

class _MarketplaceCardState extends State<MarketplaceCard> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.post.isSaved ?? false;
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
            likeCount: widget.post.likeCount,
            imagesCount: widget.post.imageUrls.length,
            isLikedByCurrentUser: widget.post.isLikedByCurrentUser,
            postType: 3,
            title: widget.post.title,
            authorImageUrl: widget.post.authorImageUrl,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = SizeConfig.width(context);
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
              PostTypeTag(label: AppConstants.question),
            ],
          ),

          const SizedBox(height: 16),

          // ── Title & Price ─────────────────────────────────────
          Text(
            widget.post.title,
            style: AppStyle.titleOfContainer.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              const Text(
                '\$45',
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
              Flexible(
                child: Text(
                  ' New Cairo',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Description ───────────────────────────────────────
          Text(widget.post.content, style: AppStyle.containerSubtitle),

          const SizedBox(height: 16),

          // ── Images ────────────────────────────────────────────
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.post.imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.post.imageUrls.isNotEmpty
                      ? Image.network(
                          widget.post.imageUrls[index],
                          fit: BoxFit.cover,
                        )
                      : widget.post.imageUrls.isNotEmpty
                      ? Image.asset(
                          widget.post.imageUrls[index],
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_outlined, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Divider(),

          // ── Action buttons ────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildIconBtn(
                _isSaved ? Icons.bookmark : Icons.bookmark_border,
                AppStrings.of(context).save,
                _handleSave,
                color: _isSaved ? AppColors.cyanColor : AppColors.iconGrey,
              ),
              _buildIconBtn(
                Icons.chat_bubble_outline,
                AppStrings.of(context).message,
                _handleOpenComments,
              ),
              _buildIconBtn(
                Icons.phone_outlined,
                AppStrings.of(context).call,
                () {},
              ),
              _buildIconBtn(
                Icons.share_outlined,
                AppStrings.of(context).share,
                () {},
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── View Details ──────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _handleOpenComments,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(color: Colors.cyan),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconBtn(
    IconData icon,
    String label,
    VoidCallback onPressed, {
    Color color = AppColors.iconGrey,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
