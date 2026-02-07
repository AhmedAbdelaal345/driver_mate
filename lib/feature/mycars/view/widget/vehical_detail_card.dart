import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VehicleDetailCard extends StatelessWidget {
  const VehicleDetailCard({
    super.key,
    required this.car,
  });

  final VechicleModel car;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f24,
      ).copyWith(color: AppColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// car icon
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.blue, AppColors.veryDarkBlue],
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImagePath.carIconPath,
                width: 40,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          /// info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.brand ?? "Unknown",
                  style: AppStyle.boldTextStyle,
                ),

                Text(
                  "${car.model ?? ""} • ${car.year ?? ""}",
                  style: AppStyle.hintStyle,
                ),

                const SizedBox(height: 8),

                /// status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Active",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                _buildServiceInfo(
                  Icons.calendar_today,
                  "Mileage: ${car.millAge ?? 0}",
                ),

                const SizedBox(height: 4),

                _buildServiceInfo(
                  Icons.confirmation_number,
                  "Plate: ${car.plateNumber ?? "-"}",
                  isNext: true,
                ),
              ],
            ),
          ),

          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
        ],
      ),
    );
  }

  Widget _buildServiceInfo(IconData icon, String text, {bool isNext = false}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: isNext ? AppColors.blue : Colors.grey),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isNext ? AppColors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }
}
