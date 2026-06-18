import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/home/view/widget/icon_container_widget.dart';
import 'package:flutter/material.dart';

class ContainerItem extends StatelessWidget {
  const ContainerItem({
    super.key,
    this.title,
    this.subTitle,
    this.bottom,
    this.containerColor,
    this.iconColor,
    this.iconPath,
    this.onTap,
  });
  final String? title;
  final String? subTitle;
  final String? bottom;
  final String? iconPath;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? containerColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
          color: Theme.of(
            context,
          ).cardTheme.color, // ← was hardcoded AppColors.white
        ),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconContainerWidget(
                icon: iconPath ?? AppImagePath.hintIconPath,
                containerColor:
                    containerColor ??
                    AppColors.cyanColor.withValues(alpha: 0.1),
                iconColor: iconColor ?? AppColors.cyanColor,
              ),
              SizedBox(height: 12),
              Text(
                title ?? AppStrings.of(context).savedItem,
                style: AppStyle.titleOfContainer.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface, // ← was hardcoded AppColors.black
                  fontSize: AppFontSize.f14,
                ),
              ),
              Text(
                subTitle ?? AppStrings.of(context).carservice,
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary, // ← was hardcoded AppColors.black
                  fontSize: AppFontSize.f12,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bottom ?? AppStrings.of(context).open,
                    style: AppStyle.viewAll.copyWith(
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    color: iconColor ?? AppColors.cyanColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
