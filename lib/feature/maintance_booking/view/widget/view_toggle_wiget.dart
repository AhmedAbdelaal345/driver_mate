import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/toggle_button_widget.dart';
import 'package:flutter/material.dart';

class ViewToggle extends StatelessWidget {
  const ViewToggle({super.key, required this.isMapView, required this.onChanged});

  final bool isMapView;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.containerGrey),
      child: Row(
        children: [
          Expanded(
            child: ToggleButton(
              text: AppConstants.listView,
              icon: Icons.list,
              isActive: !isMapView,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: ToggleButton(
              text: AppConstants.mapView,
              icon: Icons.map_outlined,
              isActive: isMapView,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}
