import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:driver_mate/core/utils/app_colors.dart';

class ContainerForIcon extends StatelessWidget {
  const ContainerForIcon({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Theme.of(
        context,
      ).colorScheme.secondary.withValues(alpha: .1),
      backgroundImage: _getImageProvider(),
      child: _showChildIfNeeded(),
    );
  }

  ImageProvider? _getImageProvider() {
    if (iconPath.startsWith("http")) {
      return NetworkImage(iconPath);
    }

    if (File(iconPath).existsSync()) {
      return FileImage(File(iconPath));
    }

    if (!iconPath.endsWith(".svg")) {
      return AssetImage(iconPath);
    }

    return null;
  }

  Widget? _showChildIfNeeded() {
    if (iconPath.endsWith(".svg")) {
      return SvgPicture.asset(iconPath, width: 30, height: 30);
    }

    return null;
  }
}
