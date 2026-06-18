import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class DeleteVehicleWidget extends StatelessWidget {
  const DeleteVehicleWidget({
    super.key,
    this.onTap,
    this.title,
    this.subTitle,
    this.buttonText,
  });

  final VoidCallback? onTap;
  final String? title;
  final String? subTitle;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Red tint adapts: lighter in light, darker in dark
    final bgColor = theme.brightness == Brightness.dark
        ? AppColors.red.withValues(alpha: 0.08)
        : const Color(0xffFEF2F2);
    final borderColor = theme.brightness == Brightness.dark
        ? AppColors.red.withValues(alpha: 0.3)
        : const Color(0xffFECACA);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecorationWidget.customBoxDecoration(context, borderRadius: 16)
          .copyWith(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.red, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Delete Vehicle',
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f16,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subTitle ??
                          'This will permanently remove this vehicle and all its maintenance history.',
                      style: AppStyle.containerSubtitle.copyWith(
                        color: theme.textTheme.bodyMedium?.color,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              side: const BorderSide(color: AppColors.red, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.delete_outline, color: AppColors.red),
            label: Text(
              buttonText ?? 'Delete Vehicle',
              style: AppStyle.boldSmallText.copyWith(
                color: AppColors.red,
                fontSize: AppFontSize.f14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}