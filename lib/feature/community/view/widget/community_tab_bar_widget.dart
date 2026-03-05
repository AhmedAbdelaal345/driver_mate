import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:flutter/material.dart';

class CommunityTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CommunityTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppFontSize.f48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppFontSize.f16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            selectedColor: AppColors.cyanColor,
            labelStyle: TextStyle(
              color: selected ? Colors.white : AppColors.textGrey,
            ),
            onSelected: (_) => onChanged(index),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: tabs.length,
      ),
    );
  }
}
