import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCarContainer extends StatelessWidget {
  const CustomCarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.blue, AppColors.veryDarkBlue],
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppImagePath.carIconPath,
          width: 40,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
