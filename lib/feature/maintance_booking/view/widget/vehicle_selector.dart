import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:flutter/material.dart';

class VehicleSelector extends StatelessWidget {
  const VehicleSelector({
    super.key,
    required this.vehicles,
    required this.selectedVehicle,
    required this.onVehicleSelected,
  });

  final List<VechicleModel> vehicles;
  final VechicleModel? selectedVehicle;
  final Function(VechicleModel) onVehicleSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f8,
      ).copyWith(color: AppColors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VechicleModel>(
          isExpanded: true,
          hint: Text(
            AppConstants.selectYourVehicle,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f12,
              color: AppColors.iconGrey,
            ),
          ),
          value: selectedVehicle,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.iconGrey,
          ),
          items: vehicles.map((vehicle) {
            return DropdownMenuItem<VechicleModel>(
              value: vehicle,
              child: Text(
                '${vehicle.brand} ${vehicle.model} ${vehicle.year}',
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f12,
                  color: AppColors.textGrey,
                ),
              ),
            );
          }).toList(),
          onChanged: (vehicle) {
            if (vehicle != null) {
              onVehicleSelected(vehicle);
            }
          },
        ),
      ),
    );
  }
}
