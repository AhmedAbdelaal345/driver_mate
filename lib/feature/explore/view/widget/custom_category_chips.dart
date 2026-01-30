import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCategoryChips extends StatelessWidget {
  const CustomCategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    const List<String> categories = ["All", "Cars", "Maintenance", "Tips"];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat == selected;

          return Padding(
            padding: const EdgeInsets.only(right: 10),

            child: ActionChip(
              label: Text(cat),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.white : AppColors.black,
              ),

              backgroundColor: isSelected
                  ? AppColors.cyanColor
                  : AppColors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.boarderWhiteColor, width: 1),
                borderRadius: BorderRadius.circular(999),
              ),
              onPressed: () => onSelected(cat),
            ),
          );
        },
      ),
    );
  }
}
