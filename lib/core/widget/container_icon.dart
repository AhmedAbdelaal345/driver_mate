import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContainerForIcon extends StatelessWidget {
  const ContainerForIcon({super.key, this.iconPath});
  final String? iconPath;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.cyanColor.withValues(alpha: 0.1),
      radius: 35,
      child: SvgPicture.asset(
        iconPath ?? AppImagePath.lockIconPath,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
