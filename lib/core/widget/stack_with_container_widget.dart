import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:flutter/material.dart';

class StackWithContainerWidget extends StatelessWidget {
  const StackWithContainerWidget({super.key, this.iconPath, this.icon});
  final String? iconPath;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ContainerForIcon(iconPath: iconPath ?? AppImagePath.protectIconPath),

        Positioned(
          bottom: -4,
          right: -4,
          child: CircleAvatar(
            backgroundColor: AppColors.cyanColor,
            radius: 16,
            child: Icon(icon ?? Icons.check, color: AppColors.white, size: 18),
          ),
        ),
      ],
    );
  }
}
