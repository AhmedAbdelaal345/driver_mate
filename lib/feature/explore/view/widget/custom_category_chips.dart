import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class CustomCategoryChips extends StatelessWidget {
  const CustomCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["All", "Cars", "Maintenance", "Tips"];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
              borderRadius: BorderRadius.circular(9999),
            ),
            margin: const EdgeInsets.only(right: 10),
            child: ActionChip(
              label: Text(categories[index]),
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
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
