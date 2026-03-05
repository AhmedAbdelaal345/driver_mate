import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/mycars/view/add_vehicle_page.dart';
import 'package:flutter/material.dart';

class EmptyVehicleState extends StatelessWidget {
  const EmptyVehicleState({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f8,
      ).copyWith(color: AppColors.white),
      child: Column(
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 48,
            color: AppColors.iconGrey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.noVehiclesFound,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f12,
              color: AppColors.iconGrey,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              MyNavigation.navigateTo(AddVehiclePage());
            },
            child: Text(
              AppConstants.addVehicle,
              style: AppStyle.viewAll.copyWith(fontSize: AppFontSize.f12),
            ),
          ),
        ],
      ),
    );
  }
}
