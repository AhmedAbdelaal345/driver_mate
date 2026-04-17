
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';

class VehicleStatusCard extends StatelessWidget {
  const VehicleStatusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecorationWidget.customBoxDecoration(borderRadius: 16)
            .copyWith(
              color: isSelected ? color.withValues(alpha: 0.08) : Colors.white,
              border: Border.all(
                color: isSelected ? color : AppColors.boarderWhiteColor,
                width: 1.4,
              ),
            ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : AppColors.iconGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 14),

            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyle.boldSmallText),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppStyle.containerSubtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
