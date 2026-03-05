import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ServiceCenterCard extends StatelessWidget {
  const ServiceCenterCard({super.key,  required this.center});

  final ServiceCenter center;
  @override
  Widget build(BuildContext context) {
    final isOpen = center.status == AppConstants.openNow;
    final statusColor = isOpen ? AppColors.green : AppColors.iconGrey;
    return InkWell(
      onTap: center.onTap,
      child: Container(
        decoration: BoxDecorationWidget.customBoxDecoration(
          borderRadius: AppFontSize.f12,
        ).copyWith(color: AppColors.white),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      center.name,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      center.status,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.iconGrey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    center.distance,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.iconGrey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.star, size: 14, color: AppColors.orange),
                  const SizedBox(width: 4),
                  Text(
                    "${center.rating} ${center.reviews}",
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.iconGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: center.services
                    .map(
                      (service) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          service,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    AppConstants.viewDetails,
                    style: AppStyle.viewAll.copyWith(fontSize: AppFontSize.f12),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.iconGrey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ServiceCenter {
  const ServiceCenter({
    required this.name,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.status,
    required this.services,
    required this.onTap,
  });

  final String name;
  final String distance;
  final String rating;
  final String reviews;
  final String status;
  final List<String> services;
  final void Function()? onTap;
}
