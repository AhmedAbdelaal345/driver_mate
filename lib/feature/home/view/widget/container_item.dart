import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
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
        decoration: BoxDecorationWidget.customBoxDecoration(),
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
                title ?? AppConstants.savedItem,
                style: AppStyle.titleOfContainer,
              ),
              Text(
                subTitle ?? AppConstants.carservice,
                style: AppStyle.containerSubtitle,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bottom ?? AppConstants.open,
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
