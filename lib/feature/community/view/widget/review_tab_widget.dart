import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/view/widget/community_filter_row.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/review_header_widget.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReviewHeader(),
        CommunityFilterRow(
          filters: ['All ratings', '5.0 ★', '4.0 ★+', 'Nearby', 'Most Recent'],
        ),
        SizedBox(height: 8),
        CommunityPostList(
          filterType: AppConstants.review,
          showEmptyState: true,
        ),
      ],
    );
  }
}

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key,
    required this.post, // ✅ real post — backs the like logic (id / likeCount / isLikedByCurrentUser)
    this.shopName = 'Auto Care Center',
    this.reviewerName = 'Ahmed Hassan',
    this.reviewerInitials = 'AH',
    this.reviewText =
        'Excellent service! Quick oil change and thorough inspection. Staff was very professional.',
    this.location = 'Downtown Plaza',
    this.timeAgo = '2 days ago',
    this.rating = 5,
  });

  final CommunityFetchPostModel post;

  final String shopName;
  final String reviewerName;
  final String reviewerInitials;
  final String reviewText;
  final String location;
  final String timeAgo;
  final int rating;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late bool _isLiked;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLikedByCurrentUser;
    _likesCount = widget.post.likeCount;
  }

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });
    context.read<CommunityPostCubit>().toggleLike(postId: widget.post.id);
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
          // ── Shop name ──────────────────────────────────────────────
          Text(
            widget.shopName,
            style: AppStyle.titleOfContainer.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // ✅
          ),

          SizedBox(height: h * 0.008),

          // ── Stars ──────────────────────────────────────────────────
          Row(
            children: [
              ...List.generate(
                5,
                (i) => Icon(
                  i < widget.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: w * 0.045,
                ),
              ),
              SizedBox(width: w * 0.02),
              Text(
                widget.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  fontSize: AppFontSize.f13,
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.012),

          // ── Review text ────────────────────────────────────────────
          Text(
            widget.reviewText,
            style: AppStyle.containerSubtitle.copyWith(
              height: 1.4,
              color: theme.textTheme.bodyMedium?.color,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis, // ✅
          ),

          SizedBox(height: h * 0.015),

          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            height: 1,
          ),

          SizedBox(height: h * 0.012),

          // ── Reviewer row — overflow fixed with Flexible ────────────
          Row(
            children: [
              CircleAvatar(
                radius: w * 0.04,
                backgroundColor: AppColors.cyanColor,
                child: Text(
                  widget.reviewerInitials.length >= 2
                      ? widget.reviewerInitials.substring(0, 2)
                      : widget.reviewerInitials,
                  style: TextStyle(fontSize: w * 0.028, color: AppColors.white),
                ),
              ),

              SizedBox(width: w * 0.02),

              // Name + time — Flexible so it doesn't push location off screen
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: TextStyle(
                        fontSize: AppFontSize.f12,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // ✅
                    ),
                    Text(
                      widget.post.createdAt,
                      style: TextStyle(
                        fontSize: AppFontSize.f10,
                        color: AppColors.iconGrey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: w * 0.02),

              // Location — Flexible so it shrinks if name is long
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: w * 0.035,
                      color: AppColors.iconGrey,
                    ),
                    SizedBox(width: w * 0.01),
                    Flexible(
                      child: Text(
                        widget.location,
                        style: TextStyle(
                          color: AppColors.iconGrey,
                          fontSize: AppFontSize.f11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // ✅
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

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

          SizedBox(height: h * 0.01),

          // ── Helpful + share ────────────────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  _handleLike();
                }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: w * 0.045,
                      color: _isLiked
                          ? AppColors.cyanColor
                          : AppColors.iconGrey,
                    ),
                    SizedBox(width: w * 0.01),
                    Text(
                      _likesCount > 0 ? '$_likesCount helpful' : 'Helpful?',
                      style: TextStyle(
                        color: _isLiked
                            ? AppColors.cyanColor
                            : AppColors.iconGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.share_outlined,
                  size: w * 0.045,
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
