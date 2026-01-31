import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FooterIconWidget extends StatelessWidget {
  FooterIconWidget({
    super.key,
    this.onPressedForBookMark,
    this.onPressedForLove,
    this.onPressedForShare,
    this.onPressedForchat,
    this.isPressedForBookMark,
    this.isPressedForLove,
  });
  final Function()? onPressedForLove;
  final Function()? onPressedForchat;
  final Function()? onPressedForShare;
  final Function()? onPressedForBookMark;
  bool? isPressedForLove;
  bool? isPressedForBookMark;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressedForLove,
          icon: Icon(
            isPressedForLove == true || isPressedForLove != null
                ? Icons.favorite
                : Icons.favorite_border_rounded,
            color: isPressedForLove == true || isPressedForLove != null
                ? AppColors.red
                : AppColors.iconGrey,
          ),
        ),
        IconButton(
          onPressed: onPressedForchat,
          icon: const Icon(
            Icons.chat_bubble_outline,
            color: AppColors.iconGrey,
          ),
        ),
        IconButton(
          onPressed: onPressedForShare,
          icon: const Icon(Icons.share, color: AppColors.iconGrey),
        ),
        IconButton(
          onPressed: onPressedForBookMark,
          icon: isPressedForBookMark == true || isPressedForBookMark != null
              ? Icon(Icons.bookmark_border, color: AppColors.cyanColor)
              : Icon(Icons.bookmark, color: AppColors.iconGrey),
        ),
      ],
    );
  }
}
