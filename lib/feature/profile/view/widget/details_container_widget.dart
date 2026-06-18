import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsContainerWidget extends StatelessWidget {
  const DetailsContainerWidget({
    super.key,
    this.title,
    this.subTitle,
    this.iconpath,
    this.onTap,
    this.icon,
    this.isSvg,
  });
  final void Function()? onTap;
  final String? title;
  final String? subTitle;
  final String? iconpath;
  final IconData? icon;
  final bool? isSvg;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          
          leading: CircleAvatar(
            radius: AppFontSize.f25,
      
            backgroundColor: AppColors.containerGrey,
            child: isSvg ?? true
                ? SvgPicture.asset(
                    iconpath ?? AppImagePath.profilePersonIconPath,
                    fit: BoxFit.scaleDown,
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      AppColors.cyanColor,
                      BlendMode.dstIn,
                    ),
                  )
                : Icon(icon, color: AppColors.cyanColor, size: 18),
          ),
          title: Text(
            title ?? AppStrings.of(context).personalInfo,
            style: AppStyle.titleForContainer.copyWith(
              color: Theme.of(context).colorScheme.onSurface, // ← was hardcoded AppColors.black
            ),
          ),
          subtitle: Text(
            subTitle ?? AppStrings.of(context).namePhone,
            style: AppStyle.containerSubtitle.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color, // ← was hardcoded AppColors.black
            ),
          ),
          
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ),
    );
  }
}
