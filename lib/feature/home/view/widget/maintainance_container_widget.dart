import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
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
  });

  final String? title;
  final String? subTitle;
  final String? imagePath;
  final String? statusText;
  final Color? statusTextColor;
  final Color? statusContainerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f16,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            dense: true,
            minVerticalPadding: 0,

            leading: Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cyanColor.withValues(alpha: 0.1),
                ),
                color: AppColors.cyanColor.withValues(alpha: 0.1),
                boxShadow: [BoxShadow(blurRadius: 4)],
              ),
              child: SvgPicture.asset(
                AppImagePath.repairIconPath,
                colorFilter: ColorFilter.mode(
                  AppColors.cyanColor,
                  BlendMode.srcIn,
                ),
              ),
            ),

            title: Text(
              title ?? AppConstants.oilChangeTitle,
              style: AppStyle.titleOfContainer,
            ),

            subtitle: Text(
              subTitle ?? AppConstants.due,
              style: AppStyle.containerSubtitle,
            ),

            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: statusContainerColor ?? AppColors.silentIvory,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColors.black.withValues(alpha: 0.15),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                statusText ?? AppConstants.soon,
                style: AppStyle.stateContainerStyle.copyWith(
                  color: statusTextColor ?? AppColors.orange,
                ),
              ),
            ),
          ),

          SizedBox(height: SizeConfig.height(context) * 0.015),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: double.infinity,
              child: PrimaryElevatedButtonWidget(
                buttonText: AppConstants.bookNow,
                onPressed: () {},
              ).copyWith(backgroundColor: AppColors.cyanColor),
            ),
          ),

          SizedBox(height: SizeConfig.height(context) * 0.02),
        ],
      ),
    );
  }
}
