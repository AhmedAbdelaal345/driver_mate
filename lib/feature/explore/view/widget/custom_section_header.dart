import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({
    super.key,
    this.title,
    this.showViewAll = true,
    this.onViewAll,
  });

  final String? title;
  final bool showViewAll;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? 'Featured Cars',
          style:  TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (showViewAll)
          TextButton(
            onPressed: onViewAll ?? () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Row(
              children: const [
                Text(
                  AppConstants.viewAll,
                  style: TextStyle(
                    color: AppColors.cyanColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.cyanColor,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
