import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? "Featured Cars",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                AppConstants.viewAll,
                style: TextStyle(color: AppColors.cyanColor),
              ),
              Icon(Icons.arrow_forward, size: 16, color: AppColors.cyanColor),
            ],
          ),
        ),
      ],
    );
  }
}
