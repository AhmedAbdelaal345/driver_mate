import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, this.firstText, this.secondText});
  final String? firstText;
  final String? secondText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Light → lightBlue tint  |  Dark → primary with low opacity
    final bgColor = theme.brightness == Brightness.dark
        ? AppColors.cyanColor.withValues(alpha: 0.1)
        : AppColors.lightBleu;

    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
        color: bgColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstText ?? AppStrings.of(context).keepYourInfo,
            style: AppStyle.boldSmallText.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            secondText ?? AppStrings.of(context).informationHelp,
            style: AppStyle.regularSmallText.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }
}