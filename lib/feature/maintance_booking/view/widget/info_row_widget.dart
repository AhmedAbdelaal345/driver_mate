import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.showAction = false,
    this.actionIcon,
    this.actionText,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool showAction;
  final IconData? actionIcon;
  final String? actionText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showAction ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecorationWidget.customBoxDecoration(context,
          borderRadius: AppFontSize.f12,
        ).copyWith(color: AppColors.containerGrey.withValues(alpha: 0.3)),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(AppFontSize.f8),
              ),
              child: Icon(icon, color: AppColors.iconGrey, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.iconGrey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showAction) ...[
              const SizedBox(width: 8),
              if (actionIcon != null)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor.withValues(alpha:  0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Icon(actionIcon, color: AppColors.cyanColor, size: 18),
                )
              else if (actionText != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    actionText!,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
