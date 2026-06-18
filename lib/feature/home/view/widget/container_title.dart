import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ContainerTitle extends StatelessWidget {
  const ContainerTitle({
    super.key,
    this.onTap,
    this.title,
    this.subTitle,
    this.isAppear,
  });
  final String? title;
  final String? subTitle;
  final Function()? onTap;
  final bool? isAppear;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Row(
        children: [
          Text(
            title ?? AppStrings.of(context).upcomingMaintence,
            style: AppStyle.titleForContainer.copyWith(
              color: Theme.of(context).colorScheme.onSurface, // ← was hardcoded AppColors.black
            ),
          ),
          Spacer(),
          isAppear == true || isAppear == null
              ? Row(
                  children: [
                    Text(
                      subTitle ?? AppStrings.of(context).viewAll,
                      style: AppStyle.viewAll,
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.cyanColor,
                      size: AppFontSize.f14,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
