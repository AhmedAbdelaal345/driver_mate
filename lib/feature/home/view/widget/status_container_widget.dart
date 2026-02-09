import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class StatusContainerWidget extends StatelessWidget {
  const StatusContainerWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.vehicleStatus,
          style: AppStyle.coursalSubtitleTextStyle.copyWith(
            color: AppColors.black,
            fontSize: AppFontSize.f16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.height(context) * 0.015),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.width(context) * 0.03),
                  decoration: BoxDecorationWidget.customBoxDecoration(
                    borderRadius: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: SizeConfig.width(context) * 0.1,
                        height: SizeConfig.width(context) * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.smoothGreen.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.health_and_safety_outlined,
                          size: AppFontSize.f20,
                          color: AppColors.green,
                        ),
                      ),
                      SizedBox(width: SizeConfig.width(context) * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.engineHealth,
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: AppColors.textGrey,
                                fontSize: AppFontSize.f12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              AppConstants.good,
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.width(context) * 0.04,
            ), // Spacing between cards
            Expanded(
              child: Container(
                padding: EdgeInsets.all(SizeConfig.width(context) * 0.03),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.width(context) * 0.1,
                      height: SizeConfig.width(context) * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.babyBleu.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.ev_station_outlined,
                        size: AppFontSize.f20,
                        color: AppColors.babyBleu,
                      ),
                    ),
                    SizedBox(width: SizeConfig.width(context) * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.batteryHealth,
                            style: AppStyle.coursalSubtitleTextStyle.copyWith(
                              color: AppColors.textGrey,
                              fontSize: AppFontSize.f12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            AppConstants
                                .attention, // Should ideally be "Normal" or based on data
                            style: AppStyle.coursalSubtitleTextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
