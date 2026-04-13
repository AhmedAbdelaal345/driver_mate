import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:flutter/material.dart';

class VehicleHeaderCard extends StatelessWidget {
  const VehicleHeaderCard({
    super.key,
    required this.vehicle,
  });

  final VechicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(SizeConfig.width(context) * 0.05),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.veryDarkBlue,
            AppColors.cyanColor,
          ],
        ),
        borderRadius: BorderRadius.circular(AppFontSize.f16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyanColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vehicle Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.directions_car_rounded,
              color: AppColors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          // Vehicle Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getVehicleTitle(),
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f18,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _getVehicleSubtitle(),
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f13,
                    color: AppColors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12),
                // Active Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.green,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 14,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppConstants.active,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f11,
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getVehicleTitle() {
    final brand = (vehicle.brand ?? "").trim();
    final model = (vehicle.model ?? "").trim();
    if (brand.isEmpty && model.isEmpty) {
      return AppConstants.yourVehicle;
    }
    if (brand.isEmpty) return model;
    if (model.isEmpty) return brand;
    return "$brand $model";
  }

  String _getVehicleSubtitle() {
    if (vehicle.year == null) {
      return AppConstants.model;
    }
    return "${vehicle.year} ${AppConstants.model}";
  }
}