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
          width: SizeConfig.width(context) * 0.4,
          height: SizeConfig.height(context) * 0.1,
          decoration: BoxDecorationWidget.customBoxDecoration(),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.width(context) * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    icon,
                    height:
                        SizeConfig.height(context) *
                        0.035, // Consistent icon height
                    width: SizeConfig.height(context) * 0.035,
                    fit: BoxFit.contain,
                  ),
                ),
                // SizedBox(height: SizeConfig.height(context) * 0.0005),
                Text(
                  text,
                  style: AppStyle.coursalSubtitleTextStyle.copyWith(
                    color: AppColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
