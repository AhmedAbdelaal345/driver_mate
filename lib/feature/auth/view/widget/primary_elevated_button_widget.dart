import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class PrimaryElevatedButtonWidget extends StatelessWidget {
  const PrimaryElevatedButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.padding,
    this.backgroundColor,
    this.icon,
    this.width,
    this.formKey,
    this.height,
    this.isExpanded = true,
  });
  final GlobalKey<FormState>? formKey;
  final String buttonText;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final IconData? icon;

  final double? width;
  final double? height;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? (width ?? double.infinity) : width,
      height: height ?? SizeConfig.height(context) * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f8),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: backgroundColor == AppColors.white
                      ? AppColors.darkBlue
                      : AppColors.white,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                buttonText,
                overflow: TextOverflow.ellipsis,
                style: AppStyle.buttonTextStyle.copyWith(
                  color: backgroundColor == AppColors.white
                      ? AppColors.darkBlue
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
