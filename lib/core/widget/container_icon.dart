import 'dart:io';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContainerForIcon extends StatelessWidget {
  const ContainerForIcon({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.cyanColor.withValues(alpha: 0.1),
      radius: 35,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    // صورة svg من assets
    if (iconPath.endsWith(".svg")) {
      return SvgPicture.asset(iconPath, width: 30, height: 30);
    }

    // صورة من الجهاز (file path)
    if (iconPath.startsWith("C:") ||
        iconPath.startsWith("/data") ||
        iconPath.startsWith("/storage")) {
      return ClipOval(
        child: Image.file(
          File(iconPath),
          fit: BoxFit.cover,
          width: 70,
          height: 70,
        ),
      );
    }

    // صورة png/jpg من assets
    return Image.asset(iconPath, width: 30, height: 30);
  }
}
