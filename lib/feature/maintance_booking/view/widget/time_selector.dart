import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class TimeSelector extends StatelessWidget {
  const TimeSelector({
    super.key,
    required this.timeSlots,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  final List<String> timeSlots;
  final String? selectedTime;
  final Function(String) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final time = timeSlots[index];
        final isSelected = time == selectedTime;

        return InkWell(
          onTap: () => onTimeSelected(time),
          borderRadius: BorderRadius.circular(AppFontSize.f8),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.cyanColor : AppColors.white,
              borderRadius: BorderRadius.circular(AppFontSize.f8),
              border: Border.all(
                color: isSelected
                    ? AppColors.cyanColor
                    : AppColors.containerGrey,
              ),
            ),
            child: Center(
              child: Text(
                time,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f11,
                  color: isSelected ? AppColors.white : AppColors.textGrey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
