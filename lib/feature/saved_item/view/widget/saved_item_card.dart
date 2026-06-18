import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedItemCard extends StatefulWidget {
  final SavedItemModel item;
  const SavedItemCard({super.key, required this.item});

  @override
  State<SavedItemCard> createState() => _SavedItemCardState();
}

class _SavedItemCardState extends State<SavedItemCard> {
  bool isBookmarked = true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SavedItemCubit>();
    final state = cubit.state;
    if (state is SavedItemLoaded) {
      isBookmarked = state.items.any((e) => e.title == widget.item.title);
    }
  }

  // ── badge color per type ──────────────────────────────────────────────────
  Color _badgeColor() {
    switch (widget.item.type) {
      case SavedType.car:
        return AppColors.cyanColor;
      case SavedType.service:
        return AppColors.orange;
      case SavedType.article:
        return AppColors.green;
      case SavedType.post:
        return AppColors.purple;
    }
  }

  String _badgeLabel() {
    switch (widget.item.type) {
      case SavedType.car:
        return "Car";
      case SavedType.service:
        return "Service";
      case SavedType.article:
        return "Article";
      case SavedType.post:
        return "Post";
    }
  }

  // ── bottom metadata row ───────────────────────────────────────────────────
  Widget _metaRow() {
    switch (widget.item.type) {
      // ★ 4.8  📍 2.5 km
      case SavedType.service:
        return Row(
          children: [
            const Icon(Icons.star, size: 14, color: AppColors.orange),
            const SizedBox(width: 4),
            Text(
              widget.item.rating ?? "4.8",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.textGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.location_on_outlined,
              size: 14,
              color: AppColors.iconGrey,
            ),
            const SizedBox(width: 4),
            Text(
              widget.item.distance ?? "— km",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.iconGrey,
                fontSize: 12,
              ),
            ),
          ],
        );

      // ♡ 42  💬 15
      case SavedType.post:
        return Row(
          children: [
            const Icon(
              Icons.favorite_border,
              size: 14,
              color: AppColors.iconGrey,
            ),
            const SizedBox(width: 4),
            Text(
              widget.item.likes?.toString() ?? "0",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.iconGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.chat_bubble_outline,
              size: 14,
              color: AppColors.iconGrey,
            ),
            const SizedBox(width: 4),
            Text(
              widget.item.comments?.toString() ?? "0",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.iconGrey,
                fontSize: 12,
              ),
            ),
          ],
        );

      // 🕐 5 min read
      case SavedType.article:
        return Row(
          children: [
            const Icon(Icons.access_time, size: 14, color: AppColors.iconGrey),
            const SizedBox(width: 4),
            Text(
              widget.item.readTime ?? "5 min read",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.iconGrey,
                fontSize: 12,
              ),
            ),
          ],
        );

      // 📅 2023  💰 SAR 285,000
      case SavedType.car:
        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                widget.item.year ?? "—",
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.textGrey,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.item.price ?? "",
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.cyanColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
    }
  }

  // ── image widget (handles missing / placeholder) ──────────────────────────
  Widget _buildImage() {
    final path = widget.item.image;
    final isNetwork = path.startsWith("http");

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: isNetwork
          ? Image.network(
              path,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _imagePlaceholder(),
            )
          : Image.asset(
              path,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _imagePlaceholder(),
            ),
    );
  }

  Widget _imagePlaceholder() => Container(
    width: 90,
    height: 90,
    decoration: BoxDecoration(
      color: AppColors.containerGrey,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(
      Icons.image_not_supported_outlined,
      color: AppColors.iconGrey,
    ),
  );

  // ── toggle bookmark ───────────────────────────────────────────────────────
  void _toggleBookmark() {
    setState(() => isBookmarked = !isBookmarked);
    final cubit = context.read<SavedItemCubit>();
    final copy = SavedItemModel(
      title: widget.item.title,
      subtitle: widget.item.subtitle,
      image: widget.item.image,
      type: widget.item.type,
      readTime: widget.item.readTime,
      comments: widget.item.comments,
      distance: widget.item.distance,
      likes: widget.item.likes,
      price: widget.item.price,
      rating: widget.item.rating,
      year: widget.item.year,
    );
    if (isBookmarked) {
      cubit.addItem(copy);
      AppNotifier.show(
        context,
        "Item Saved Successfully",
        type: NotifierType.success,
      );
    } else {
      cubit.removeItem(copy);
      AppNotifier.show(
        context,
        "Item Removed Successfully",
        type: NotifierType.error,
      );
    }
  }

  // ── build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final badgeColor = _badgeColor();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
        color: AppColors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── thumbnail ──
          _buildImage(),

          const SizedBox(width: 16),

          // ── content ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // type badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _badgeLabel(),
                    style: AppStyle.containerSubtitle.copyWith(
                      color: badgeColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // title
                Text(
                  widget.item.title,
                  style: AppStyle.titleOfContainer,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // subtitle
                Text(
                  widget.item.subtitle,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: AppColors.midGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // metadata row
                _metaRow(),
              ],
            ),
          ),

          // ── bookmark icon ──
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: _toggleBookmark,
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border_rounded,
              color: AppColors.cyanColor,
            ),
          ),
        ],
      ),
    );
  }
}
