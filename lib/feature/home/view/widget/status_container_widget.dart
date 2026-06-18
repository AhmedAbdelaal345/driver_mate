import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
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
          AppStrings.of(context).vehicleStatus,
          style: AppStyle.coursalSubtitleTextStyle.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface, // ← was hardcoded AppColors.textGrey
            fontSize: AppFontSize.f16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.height(context) * 0.015),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(SizeConfig.width(context) * 0.06),
            decoration: BoxDecorationWidget.customBoxDecoration(context,
              borderRadius: 12,
            ).copyWith(color: Theme.of(context).cardTheme.color),
            child: Row(
              children: [
                Expanded(
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
                              AppStrings.of(context).engineHealth,
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface, // ← was hardcoded AppColors.textGrey
                                fontSize: AppFontSize.f12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              AppStrings.of(context).good,
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface, // ← was hardcoded AppColors.black
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.width(context) * 0.04,
                ), // Spacing between cards
                Expanded(
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
                              AppStrings.of(context).oilhealth,
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface, // ← was hardcoded AppColors.textGrey
                                fontSize: AppFontSize.f12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              AppStrings.of(
                                context,
                              ).normal, // Should ideally be "Normal" or based on data
                              style: AppStyle.coursalSubtitleTextStyle.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface, // ← was hardcoded AppColors.black
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
    );
  }
}
