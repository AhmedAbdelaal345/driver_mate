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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: 16,
      ).copyWith(
        color: const Color(0xffFEF2F2),
        border: Border.all(
          color: const Color(0xffFECACA),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "Delete Vehicle",
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f16,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subTitle ??
                          "This will permanently remove this vehicle and all its maintenance history.",
                      style: AppStyle.containerSubtitle.copyWith(
                        color: AppColors.textGrey,
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// Button
          OutlinedButton.icon(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              side: const BorderSide(
                color: Colors.redAccent,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
            label: Text(
              buttonText ?? "Delete Vehicle",
              style: AppStyle.boldSmallText.copyWith(
                color: Colors.redAccent,
                fontSize: AppFontSize.f14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}