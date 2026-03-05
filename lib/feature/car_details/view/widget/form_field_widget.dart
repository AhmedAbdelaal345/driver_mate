import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.label,
    required this.child,
    this.isOptional = false,
  });

  final String label;
  final Widget child;
  final bool isOptional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: AppStyle.boldSmallText.copyWith(
              fontSize: AppFontSize.f13,
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
            ),
            children: [
              if (isOptional)
                TextSpan(
                  text: ' (Optional)',
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f12,
                    color: AppColors.iconGrey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
