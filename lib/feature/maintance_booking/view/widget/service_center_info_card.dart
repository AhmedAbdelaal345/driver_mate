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
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceCenter.name ?? "No Name",
            style: AppStyle.boldSmallText.copyWith(
              fontSize: AppFontSize.f14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
               Icon(
                Icons.location_on_outlined,
                size: 14,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  serviceCenter.address ?? "No Address",
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
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
