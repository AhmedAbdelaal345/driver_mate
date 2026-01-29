import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class AiBubbleWidget extends StatelessWidget {
  const AiBubbleWidget({
    super.key,
    required this.text,
    this.action,
    this.onTap,
  });
  final String text;
  final String? action;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImagePath.brainImagePath,
          fit: BoxFit.scaleDown,
          width: 35,
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: 13,
                  color: AppColors.black,
                ),
              ),

              if (action != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cyanColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.cyanColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          action ?? "",
                          style: AppStyle.viewAll.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
