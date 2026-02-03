import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

enum ThemeModeOption { light, dark, system }

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.previewBackground,
    required this.previewCard,
    required this.previewLine,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final Color previewBackground;
  final Color previewCard;
  final Color previewLine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? AppColors.cyanColor
        : AppColors.boarderWhiteColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppFontSize.f12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecorationWidget.customBoxDecoration(
          borderRadius: AppFontSize.f12,
        ).copyWith(
          color: AppColors.white,
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.cyanColor, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                ),
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.cyanColor
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.cyanColor
                          : AppColors.boarderWhiteColor,
                      width: 1.2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 12,
                          color: AppColors.white,
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: previewBackground,
                borderRadius: BorderRadius.circular(AppFontSize.f12),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 6,
                        width: 42,
                        decoration: BoxDecoration(
                          color: previewLine.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 6,
                        width: 26,
                        decoration: BoxDecoration(
                          color: previewLine.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 60,
                    height: 44,
                    decoration: BoxDecoration(
                      color: previewCard,
                      borderRadius: BorderRadius.circular(AppFontSize.f10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
