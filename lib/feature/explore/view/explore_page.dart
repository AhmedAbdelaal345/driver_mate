import 'package:driver_mate/feature/explore/view/widget/custom_car_slider.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_category_chips.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_maintenance_list.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_recommendation_banner.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_section_header.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
            CustomRecommendationBanner(),
            const SizedBox(height: 20),
            CustomCategoryChips(),
            const SizedBox(height: 25),
            CustomSectionHeader(title: AppConstants.featuredCars),
            const SizedBox(height: 15),
            CustomCarSlider(),
            const SizedBox(height: 25),
            CustomSectionHeader(title: AppConstants.maintanenceNearService),
            const SizedBox(height: 15),
            CustomMaintenanceList(),
          ],
        ),
      ),
    );
  }

  // Reuse your BoxDecoration logic for consistency
}
