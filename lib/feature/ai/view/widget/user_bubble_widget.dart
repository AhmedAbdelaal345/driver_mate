import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class UserBubbleWidget extends StatelessWidget {
  const UserBubbleWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: SizeConfig.width(context) * 0.75,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: [
              // AppColors.darkBlue,
              AppColors.veryDarkBlue,
              AppColors.blue,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(2),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: AppStyle.coursalSubtitleTextStyle.copyWith(
            fontSize: 13,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
