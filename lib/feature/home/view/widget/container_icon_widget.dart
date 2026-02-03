import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 15,
                  width: 20,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Flexible(
                  child: Text(
                    text,
                    style: AppStyle.coursalSubtitleTextStyle.copyWith(
                      color: AppColors.black,
                      fontSize: AppFontSize.f12,
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
