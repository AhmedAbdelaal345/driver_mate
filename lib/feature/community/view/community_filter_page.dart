import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class CommunityFilterPage extends StatefulWidget {
  const CommunityFilterPage({super.key});

  @override
  State<CommunityFilterPage> createState() => _CommunityFilterPageState();
}

class _CommunityFilterPageState extends State<CommunityFilterPage> {
  final List<String> _categories = const [
    AppConstants.all,
    AppConstants.cars,
    AppConstants.maintenance,
    AppConstants.tips,
    AppConstants.community,
    AppConstants.marketPlace,
  ];

  final List<String> _locations = const [
    'Riyadh',
    'Jeddah',
    'Dammam',
    'Madinah',
  ];

  final List<String> _sortOptions = const [
    AppConstants.newest,
    AppConstants.nearest,
    AppConstants.highestRated,
    AppConstants.lowestPrice,
    AppConstants.highestPrice,
  ];

  String _selectedCategory = AppConstants.all;
  String _selectedLocation = 'Riyadh';
  String _selectedSort = AppConstants.newest;
  int _selectedRating = 3;
  RangeValues _price = const RangeValues(0, 500000);

  final TextEditingController _minPriceController =
      TextEditingController(text: '0');
  final TextEditingController _maxPriceController =
      TextEditingController(text: '500000');

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _selectedCategory = AppConstants.all;
      _selectedLocation = 'Riyadh';
      _selectedSort = AppConstants.newest;
      _selectedRating = 3;
      _price = const RangeValues(0, 500000);
      _minPriceController.text = '0';
      _maxPriceController.text = '500000';
    });
  }

  // BoxDecoration _cardDecoration() {
  //   return BoxDecoration(
  //     color: AppColors.white,
  //     borderRadius: BorderRadius.circular(16),
  //     border: Border.all(color: AppColors.boarderWhiteColor),
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.black.withValues(alpha: 0.04),
  //         blurRadius: 6,
  //         offset: const Offset(0, 2),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final horizontal = SizeConfig.width(context) * 0.05;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppConstants.filters,
          style: AppStyle.appBarTitle,
        ),
        actions: [
          TextButton(
            onPressed: _reset,
            child: Text(
              AppConstants.reset,
              style: AppStyle.viewAll.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        child: Column(
          children: [
            _SectionCard(
              title: AppConstants.category,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedColor: AppColors.cyanColor,
                    backgroundColor: AppColors.containerGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    onSelected: (_) {
                      setState(() => _selectedCategory = cat);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: AppConstants.priceRange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RangeSlider(
                    values: _price,
                    min: 0,
                    max: 500000,
                    divisions: 100,
                    activeColor: AppColors.cyanColor,
                    labels: RangeLabels(
                      _price.start.toStringAsFixed(0),
                      _price.end.toStringAsFixed(0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _price = value;
                        _minPriceController.text =
                            value.start.toStringAsFixed(0);
                        _maxPriceController.text =
                            value.end.toStringAsFixed(0);
                      });
                    },
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: _PriceField(
                          label: AppConstants.minPriceLabel,
                          controller: _minPriceController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _PriceField(
                          label: AppConstants.maxPriceLabel,
                          controller: _maxPriceController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'SAR ${_price.start.toStringAsFixed(0)} - SAR ${_price.end.toStringAsFixed(0)}',
                      style: AppStyle.viewAll.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: AppConstants.location,
              child: DropdownButtonFormField<String>(
                value: _selectedLocation,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.boarderWhiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.cyanColor),
                  ),
                ),
                items: _locations
                    .map((loc) =>
                        DropdownMenuItem(value: loc, child: Text(loc)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedLocation = value);
                },
              ),
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: AppConstants.rating,
              child: Column(
                children: [5, 4, 3].map((stars) {
                  final isSelected = _selectedRating == stars;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => _selectedRating = stars),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.cyanColor
                                : AppColors.containerGrey,
                          ),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: List.generate(
                                stars,
                                (index) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF5A524),
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$stars+ Stars',
                              style: AppStyle.boldSmallText.copyWith(
                                fontSize: AppFontSize.f12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: AppConstants.sortBy,
              child: Column(
                children: _sortOptions.map((option) {
                  final isSelected = _selectedSort == option;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => setState(() => _selectedSort = option),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.smoothcyanColor
                              : AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.cyanColor
                                : AppColors.containerGrey,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: AppStyle.boldSmallText.copyWith(
                                  fontSize: AppFontSize.f12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: AppColors.darkBlue),
                    foregroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppConstants.cancel,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppConstants.applyFilters,
                    style: AppStyle.buttonTextStyle.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.boarderWhiteColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.iconGrey,
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PriceField extends StatelessWidget {
  const _PriceField({required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.containerSubtitle.copyWith(
            color: AppColors.iconGrey,
            fontSize: AppFontSize.f11,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.boarderWhiteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.cyanColor),
            ),
          ),
        ),
      ],
    );
  }
}
