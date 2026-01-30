// feature/community/view/widget/community_filter_row.dart

import 'package:flutter/material.dart';

class CommunityFilterRow extends StatefulWidget {
  final List<String> filters;
  const CommunityFilterRow({super.key, required this.filters});

  @override
  State<CommunityFilterRow> createState() => _CommunityFilterRowState();
}

class _CommunityFilterRowState extends State<CommunityFilterRow> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: Chip(
              backgroundColor: isSelected
                  ? const Color(0xFF1B7F9B)
                  : Colors.white,
              side: BorderSide(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              label: Text(
                widget.filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              visualDensity: VisualDensity.compact,
            ),
          );
        },
      ),
    );
  }
}
