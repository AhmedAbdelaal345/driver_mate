import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AiContainerWidget extends StatelessWidget {
  const AiContainerWidget({
    super.key,
    this.title,
    this.subTitle,
    this.containerColor,
    this.iconColor,
    this.action,
    this.onTap,
    this.icon,
  });
  final String? title;
  final String? subTitle;
  final String? action;
  final Color? iconColor;
  final String? icon;
  final Function()? onTap;
  final Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
          border: BoxBorder.fromLTRB(
            left: BorderSide(
              color: iconColor ?? AppColors.orange,
              width: AppFontSize.f5,
            ),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: SizeConfig.width(context) * 0.11,
                height: SizeConfig.width(context) * 0.11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: containerColor ?? AppColors.silentIvory,
                  border: BoxBorder.all(
                    color: AppColors.boarderWhiteColor,
                    width: 1.0,
                  ),
                ),
                child: SvgPicture.asset(
                  icon ?? AppImagePath.videoIconPath,
                  colorFilter: ColorFilter.mode(
                    iconColor ?? AppColors.orange,
                    BlendMode.dstIn,
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
              title: Text(
                title ?? AppConstants.batteryHealth,
                style: AppStyle.titleOfContainer,
              ),
              subtitle: Text(
                subTitle ?? AppConstants.batteryStatus,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.midGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Text(
                    action ?? AppConstants.checkNow,
                    style: AppStyle.viewAll.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_right_alt, color: AppColors.cyanColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
