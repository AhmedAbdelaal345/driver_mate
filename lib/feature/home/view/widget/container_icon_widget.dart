import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContainerIconWidget extends StatelessWidget {
  const ContainerIconWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final String icon;
  final String text;
  final VoidCallback? onTap; // Placeholder for onTap callback
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppFontSize.f12),
        child: Container(
          decoration: BoxDecorationWidget.customBoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  SizeConfig.width(context) *
                  0.03, // Responsive horizontal padding
              vertical: SizeConfig.height(context) * 0.008, // Reduced padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height:
                      SizeConfig.height(context) *
                      0.025, // Responsive icon height ~20-25
                  width:
                      SizeConfig.width(context) * 0.05, // Responsive icon width
                  fit: BoxFit.contain,
                ),
                SizedBox(height: SizeConfig.height(context) * 0.008),
                Flexible(
                  child: Text(
                    text,
                    style: AppStyle.coursalSubtitleTextStyle.copyWith(
                      color: AppColors.black,
                      fontSize: AppFontSize
                          .f12, // Utilizing existing font size, assuming it handles scaling or is acceptable
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
