import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart'
    show PrimaryElevatedButtonWidget;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MaintainanceContainerWidget extends StatelessWidget {
  const MaintainanceContainerWidget({
    super.key,
    this.title,
    this.subTitle,
    this.statusText,
    this.imagePath,
    this.statusTextColor,
    this.statusContainerColor,
    this.onTap,
  });

  final String? title;
  final String? subTitle;
  final String? imagePath;
  final String? statusText;
  final Color? statusTextColor;
  final Color? statusContainerColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: 16,
      ).copyWith(color: Theme.of(context).cardTheme.color),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔹 HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON
                Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    imagePath ?? AppImagePath.repairIconPath,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      AppColors.cyanColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// TITLE + SUBTITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? AppStrings.of(context).oilChangeTitle,
                        style: AppStyle.titleOfContainer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subTitle ?? AppStrings.of(context).due,
                        style: AppStyle.containerSubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                /// STATUS TAG
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        statusContainerColor ??
                        AppColors.silentIvory.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    statusText ?? AppStrings.of(context).stayOnTopMaintenance,
                    style: AppStyle.stateContainerStyle.copyWith(
                      color: statusTextColor ?? AppColors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SizedBox(
              height: 42,
              width: double.infinity,
              child: PrimaryElevatedButtonWidget(
                buttonText: AppStrings.of(context).bookNow,
                onPressed: onTap,
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
