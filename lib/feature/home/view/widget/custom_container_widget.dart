import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  final String title;
  final String subtitle;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: SizeConfig.height(context) * 0.015),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      padding: EdgeInsets.all(SizeConfig.height(context) * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: SizeConfig.height(context) * 0.06,
            width: SizeConfig.width(context) * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: SizeConfig.width(context) * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.coursalSubtitleTextStyle.copyWith(
                    color: AppColors.black,
                    fontSize: AppFontSize.f14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.004),
                Text(
                  subtitle,
                  style: AppStyle.coursalSubtitleTextStyle.copyWith(
                    color: AppColors.textGrey,
                    fontSize: AppFontSize.f12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
