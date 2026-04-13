import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ServiceHistoryItem extends StatelessWidget {
  const ServiceHistoryItem({
    super.key,
    required this.title,
    required this.date,
    required this.serviceCenter,
    required this.cost,
    required this.status,
    required this.onTap,
  });

  final String title;
  final String date;
  final String serviceCenter;
  final String cost;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppFontSize.f12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecorationWidget.customBoxDecoration(
          borderRadius: AppFontSize.f12,
        ).copyWith(color: AppColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _StatusBadge(status: status),
              ],
            ),
            const SizedBox(height: 12),
            // Date
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: AppColors.iconGrey,
                ),
                const SizedBox(width: 6),
                Text(
                  date,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Service Center
            Row(
              children: [
                const Icon(
                  Icons.build_outlined,
                  size: 14,
                  color: AppColors.iconGrey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    serviceCenter,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.iconGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.containerGrey),
            const SizedBox(height: 12),
            // Cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cost',
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                ),
                Text(
                  cost,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                    color: AppColors.cyanColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase() == 'completed';
    final color = isCompleted ? AppColors.green : AppColors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}