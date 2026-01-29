import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart' show AppImagePath;
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconContainerWidget extends StatelessWidget {
  const IconContainerWidget({
    super.key,
    this.containerColor,
    this.icon,
    this.iconColor,
  });
  final Color? containerColor;
  final String? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width(context) * 0.11,
      height: SizeConfig.width(context) * 0.11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999),
        color: containerColor ?? AppColors.silentIvory,
        border: BoxBorder.all(color: AppColors.boarderWhiteColor, width: 1.0),
      ),
      child: SvgPicture.asset(
        icon ?? AppImagePath.videoIconPath,
        colorFilter: ColorFilter.mode(
          iconColor ?? AppColors.orange,
          BlendMode.dstIn,
        ),
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
