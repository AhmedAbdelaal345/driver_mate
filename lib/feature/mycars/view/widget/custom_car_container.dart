import 'dart:io';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCarContainer extends StatelessWidget {
  const CustomCarContainer({
    super.key,
    this.image,
    this.size = 80,
    this.radius = 20,
  });

  final File? image;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final bool hasImage = image != null && image!.existsSync();

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: hasImage
            ? null
            : const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blue,
                  AppColors.veryDarkBlue,
                ],
              ),
        image: hasImage
            ? DecorationImage(
                image: FileImage(image!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: hasImage
          ? null
          : Center(
              child: SvgPicture.asset(
                AppImagePath.carIconPath,
                width: size * 0.5,
                height: size * 0.5,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
    );
  }
}