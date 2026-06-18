import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter & Sort", style: AppStyle.titleOfContainer),
            SizedBox(height: 20),

            Text("Sort By"),
            SizedBox(height: 12),

            _filterButton("Newest"),
            _filterButton("Most Saved"),
            _filterButton("Quick Reads"),

            SizedBox(height: 20),

            Text("Difficulty (Optional)"),
            SizedBox(height: 12),

            Row(
              children: [
                _difficultyChip("All", true),
                SizedBox(width: 10),
                _difficultyChip("Basic", false),
                SizedBox(width: 10),
                _difficultyChip("Advanced", false),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Reset",
                      style: TextStyle(color: AppColors.blue),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkCyanColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Apply Filters",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Widget _filterButton(String text) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.cyanColor),
    ),
    child: Text(text),
  );
}

Widget _difficultyChip(String text, bool selected) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: selected ? AppColors.cyanColor : AppColors.containerGrey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      text,
      style: TextStyle(color: selected ? AppColors.white : AppColors.black),
    ),
  );
}
