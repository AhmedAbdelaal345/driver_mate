import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_tips_feed.dart';
import 'package:driver_mate/feature/explore/view/widget/explore_filter_sheet.dart';
import 'package:driver_mate/feature/home/view/widget/float_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';

import 'widget/custom_car_slider.dart';
import 'widget/custom_category_chips.dart';
import 'widget/custom_maintenance_list.dart';
import 'widget/custom_recommendation_banner.dart';
import 'widget/custom_section_header.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ExploreFilter _filter = ExploreFilter.initial;

  void _openFilterSheet() async {
    final result = await showModalBottomSheet<ExploreFilter>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ExploreFilterSheet(initial: _filter),
    );

    if (result != null) {
      setState(() => _filter = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatActionButtonWidget(
        onPressed: () {
          // here we will add the functionality to go to ai voice assisstance
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppConstants.explore,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.043,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 1. Chips are ALWAYS visible at the top
            CustomCategoryChips(
              selected: _filter.category,
              onSelected: (cat) {
                setState(() => _filter = _filter.copyWith(category: cat));
              },
            ),

            const SizedBox(height: 25),

            // 2. The dynamic section starts here
            if (_filter.category == "Tips")
              const CustomTipsFeed() // This shows the article feed from your screenshots
            else ...[
              // 3. This is the Marketplace/Explore view
              const CustomRecommendationBanner(),
              const SizedBox(height: 25),
              CustomSectionHeader(title: AppConstants.featuredCars),
              const SizedBox(height: 15),
              CustomCarSlider(filter: _filter),
              const SizedBox(height: 25),
              CustomSectionHeader(title: AppConstants.maintanenceNearService),
              const SizedBox(height: 15),
              CustomMaintenanceList(filter: _filter),
            ],
          ],
        ),
      ),
    );
  }
}
