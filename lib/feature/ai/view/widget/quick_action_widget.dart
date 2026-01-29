import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';

class QuickActionItemWidget extends StatelessWidget {
  const QuickActionItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isHighlighted = false,
    this.iconColor,
    this.onTap,
    this.borderColor,
    this.gradient,
  });

  final String icon;
  final String title;
  final String subtitle;
  final bool isHighlighted;
  final Color? iconColor;
  final Color? borderColor;
  final Gradient? gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final containerDecoration = isHighlighted
        ? BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(14),
          )
        : BoxDecorationWidget.customBoxDecoration(
            borderRadius: 14,
            borderWidth: 1,
          ).copyWith(
            border: Border.all(
              color: borderColor ?? AppColors.boarderWhiteColor,
              width: 1,
            ),
          );

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: containerDecoration,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: isHighlighted
                    ? Colors.white.withOpacity(0.25)
                    : AppColors.containerGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  iconColor ?? AppColors.cyanColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyle.titleOfContainer),
                Text(subtitle, style: AppStyle.containerSubtitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
