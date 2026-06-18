import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/view/community_comment_page.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_post_header.dart';
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
          filterType: AppStrings.of(context).marketPlace,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class MarketplaceCard extends StatefulWidget {
  const MarketplaceCard({super.key, required this.post});
  final CommunityPostModel post;

  @override
  State<MarketplaceCard> createState() => _MarketplaceCardState();
}

class _MarketplaceCardState extends State<MarketplaceCard> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.post.isSaved;
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
                radius: 18,
                backgroundColor: const Color(0xFF1B7F9B),
                child: Text(
                  widget.post.authorInitials,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.post.createdAt.toString().substring(0, 16),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              _buildPartTag(),
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
          Text(widget.post.description, style: AppStyle.containerSubtitle),

          const SizedBox(height: 16),

          // ── Images ────────────────────────────────────────────
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.post.imageFile != null
                      ? Image.file(widget.post.imageFile!,
                          fit: BoxFit.cover)
                      : widget.post.imageAssetPath != null
                          ? Image.asset(widget.post.imageAssetPath!,
                              fit: BoxFit.cover)
                          : const Icon(Icons.image_outlined,
                              color: Colors.grey),
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
              _buildIconBtn(Icons.phone_outlined, AppStrings.of(context).call, () {}),
              _buildIconBtn(Icons.share_outlined, AppStrings.of(context).share, () {}),
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

  Widget _buildPartTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.cyan.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'Part',
        style: TextStyle(
            color: Colors.cyan, fontSize: 11, fontWeight: FontWeight.bold),
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
            Text(label,
                style:
                    TextStyle(color: AppColors.textGrey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}