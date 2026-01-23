import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class StatusContainerWidget extends StatelessWidget {
  const StatusContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.boarderWhiteColor,
        border: BoxBorder.all(color: AppColors.boarderWhiteColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(0, 1),
            color: AppColors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.043,
          vertical: SizeConfig.height(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.vechicleStatus,
              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                color: AppColors.black,
                fontSize: AppFontSize.f16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.width(context) * 0.11,
                  height: SizeConfig.width(context) * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: AppColors.smoothGreen,
                    border: BoxBorder.all(
                      color: AppColors.boarderWhiteColor,
                      width: 1.0,
                    ),
                  ),
                  child: Icon(
                    Icons.health_and_safety_outlined,
                    size: AppFontSize.f20,
                    color: AppColors.green,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      AppConstants.engineHealth,
                      style: AppStyle.coursalSubtitleTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                    Text(
                      AppConstants.good,
                      style: AppStyle.coursalSubtitleTextStyle.copyWith(
                        color: AppColors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.width(context) * 0.11,
                  height: SizeConfig.width(context) * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: AppColors.smoothYellow,
                    border: BoxBorder.all(
                      color: AppColors.boarderWhiteColor,
                      width: 1.0,
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppImagePath.chargeIconPath,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      AppConstants.batteryHealth,
                      style: AppStyle.coursalSubtitleTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                    Text(
                      AppConstants.attention,
                      style: AppStyle.coursalSubtitleTextStyle.copyWith(
                        color: AppColors.yellow,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
