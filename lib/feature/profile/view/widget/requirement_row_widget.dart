import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class RequirementRow extends StatelessWidget {
  const RequirementRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.cancel, size: 16, color: AppColors.iconGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.iconGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
