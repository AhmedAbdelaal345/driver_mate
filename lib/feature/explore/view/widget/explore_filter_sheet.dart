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
  late RangeValues _price;

  final List<String> _categories = const [
    'All',
    'Sedan',
    'SUV',
    'Hatchback',
    'Truck',
    'Electric',
  ];

  @override
  void initState() {
    super.initState();
    _temp = widget.initial;
    _price = RangeValues(_temp.minPrice, _temp.maxPrice);
  }

  void _reset() {
    setState(() {
      _temp = ExploreFilter.initial;
      _price = const RangeValues(0, 100000);
    });
  }

  void _apply() {
    final applied = _temp.copyWith(
      minPrice: _price.start,
      maxPrice: _price.end,
    );
    Navigator.pop(context, applied);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final categoryValue =
        _categories.contains(_temp.category) ? _temp.category : null;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filters', style: AppStyle.titleForContainer),
              const SizedBox(height: 16),

              // Category
              Text('Category', style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: categoryValue,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                hint: const Text('Select category'),
                items: _categories
                    .toSet()
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _temp = _temp.copyWith(category: v)),
              ),

              const SizedBox(height: 20),

              // Price Range
              Text('Price Range', style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              RangeSlider(
                values: _price,
                min: 0,
                max: 100000,
                divisions: 100,
                labels: RangeLabels(
                  '\$${_price.start.toStringAsFixed(0)}',
                  '\$${_price.end.toStringAsFixed(0)}',
                ),
                onChanged: (v) => setState(() => _price = v),
              ),

              const SizedBox(height: 20),

              // Distance
              Text('Max distance (km)', style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              Slider(
                value: _temp.maxDistanceKm,
                min: 1,
                max: 100,
                divisions: 99,
                label: _temp.maxDistanceKm.toStringAsFixed(0),
                onChanged: (v) =>
                    setState(() => _temp = _temp.copyWith(maxDistanceKm: v)),
              ),

              const SizedBox(height: 20),

              // Rating
              Text('Min rating', style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              Slider(
                value: _temp.minRating,
                min: 0,
                max: 5,
                divisions: 10,
                label: _temp.minRating.toStringAsFixed(1),
                onChanged: (v) =>
                    setState(() => _temp = _temp.copyWith(minRating: v)),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _apply,
                      child: const Text('Apply'),
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
