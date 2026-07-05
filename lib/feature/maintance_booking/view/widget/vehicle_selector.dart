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
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f8,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VechicleModel>(
          isExpanded: true,
          hint: Text(
            AppConstants.selectYourVehicle,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f12,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          value: selectedVehicle,
          icon:  Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).iconTheme.color,
          ),
          items: vehicles.map((vehicle) {
            return DropdownMenuItem<VechicleModel>(
              value: vehicle,
              child: Text(
                '${vehicle.brandName} ${vehicle.modelName} ${vehicle.year}',
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f12,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
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
