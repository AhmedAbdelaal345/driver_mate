import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsContainerWidget extends StatelessWidget {
  const DetailsContainerWidget({
    super.key,
    this.title,
    this.subTitle,
    this.iconpath,
    this.onTap,
  });
  final void Function()? onTap;
  final String? title;
  final String? subTitle;
  final String? iconpath;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: AppFontSize.f25,

          backgroundColor: AppColors.containerGrey,
          child: SvgPicture.asset(
            iconpath ?? AppImagePath.profilePersonIconPath,
            fit: BoxFit.scaleDown,
            width: 40,
            height: 40,
            colorFilter: ColorFilter.mode(AppColors.cyanColor, BlendMode.dstIn),
          ),
        ),
        title: Text(
          title ?? AppConstants.personalInfo,
          style: AppStyle.titleForContainer,
        ),
        subtitle: Text(
          subTitle ?? AppConstants.namePhone,
          style: AppStyle.containerSubtitle,
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}
