import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VehicleDetailCard extends StatelessWidget {
  const VehicleDetailCard({
    super.key,
    this.carNickname,
    this.carModel,
    this.year,
    this.status,
    this.lastService,
    this.nextService,
    this.statusColor,
  });

  final String? carNickname;
  final String? carModel;
  final String? year;
  final String? status;
  final String? lastService;
  final String? nextService;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f24,
      ).copyWith(color: AppColors.white), // Assuming a white card background
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Car Icon/Image Container
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
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

          // 2. Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carNickname ?? "My Daily Driver",
                  style: AppStyle.boldTextStyle,
                ), // Use your bold style
                Text(
                  "${carModel ?? "Hyundai"} • ${year ?? "2022"}",
                  style: AppStyle.hintStyle,
                ),
                const SizedBox(height: 8),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(
                      alpha: 0.1,
                    ), // Define this in AppColors
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status ?? "In Service",
                    style: TextStyle(
                      color: statusColor ?? AppColors.orange,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Service Dates
                _buildServiceInfo(
                  Icons.build_outlined,
                  "Last service: $lastService",
                ),
                const SizedBox(height: 4),
                _buildServiceInfo(
                  Icons.calendar_today_outlined,
                  "Next service: $nextService",
                  isNext: true,
                ),
              ],
            ),
          ),

          // 3. Arrow Icon
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
