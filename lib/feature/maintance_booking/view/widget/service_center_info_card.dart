import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:flutter/material.dart';

class ServiceCenterInfoCard extends StatelessWidget {
  const ServiceCenterInfoCard({super.key, required this.serviceCenter});

  final ServiceCenterModel serviceCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceCenter.serviceCenterName ?? "No Name",
            style: AppStyle.boldSmallText.copyWith(
              fontSize: AppFontSize.f14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.iconGrey,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  serviceCenter.address ?? "No Address",
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
