import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:flutter/material.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key, required this.initial});
  final ExploreFilter initial;

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  late ExploreFilter _temp;

  final List<String> _categories = const ['All', 'Cars', 'Maintenance', 'Tips'];

  final List<String> _sortOptions = const [
    'Recommended',
    'Newest',
    'Nearest',
    'Price: Low to High',
    'Price: High to Low',
  ];

  @override
  void initState() {
    super.initState();
    _temp = widget.initial;
  }

  void _reset() {
    setState(() {
      _temp = ExploreFilter.initial;
    });
  }

  void _apply() {
    Navigator.pop(context, _temp);
  }

  Widget _buildCategoryChip(String label) {
    final isSelected = _temp.category == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.cyanColor : AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColors.white,
      selectedColor: AppColors.smoothcyanColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? AppColors.cyanColor : AppColors.boarderWhiteColor,
        ),
      ),
      onSelected: (_) {
        setState(() => _temp = _temp.copyWith(category: label));
      },
    );
  }

  Widget _buildSortTile(String label) {
    final isSelected = _temp.sortBy == label;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => setState(() => _temp = _temp.copyWith(sortBy: label)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.smoothcyanColor
              : AppColors.containerGrey,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.cyanColor
                : AppColors.boarderWhiteColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.cyanColor : AppColors.iconGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.containerGrey,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.boarderWhiteColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Use my location',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
          Switch.adaptive(
            value: _temp.useMyLocation,
            activeThumbColor: AppColors.cyanColor,
            inactiveThumbColor: AppColors.iconGrey,
            inactiveTrackColor: AppColors.boarderWhiteColor,
            onChanged: (value) {
              setState(() => _temp = _temp.copyWith(useMyLocation: value));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.boarderWhiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Filter & Sort',
                      style: AppStyle.titleForContainer.copyWith(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.iconGrey),
                  ),
                ],
              ),
              const Divider(
                height: 24,
                thickness: 1,
                color: AppColors.boarderWhiteColor,
              ),

              // Category
              Text(AppConstants.category, style: AppStyle.labelStyle),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _categories.map(_buildCategoryChip).toList(),
              ),

              const SizedBox(height: 20),

              // Sort by
              Text('Sort By', style: AppStyle.labelStyle),
              const SizedBox(height: 12),
              Column(
                children: [
                  for (final option in _sortOptions)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: option == _sortOptions.last ? 0 : 10,
                      ),
                      child: _buildSortTile(option),
                    ),
                ],
              ),

              const SizedBox(height: 20),

              // Location
              Text(AppConstants.location, style: AppStyle.labelStyle),
              const SizedBox(height: 12),
              _buildLocationTile(),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.cyanColor),
                        foregroundColor: AppColors.cyanColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _reset,
                      child: Text(
                        AppConstants.reset,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _apply,
                      child: const Text(
                        AppConstants.apply,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
