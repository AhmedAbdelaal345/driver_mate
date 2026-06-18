import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/car_details/view/car_details_page.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';
import 'package:driver_mate/feature/explore/view/explore_search_page.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_car_slider.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_category_chips.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_maintenance_list.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_recommendation_banner.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_section_header.dart';
import 'package:driver_mate/feature/explore/view/widget/custom_tips_feed.dart';
import 'package:driver_mate/feature/explore/view/widget/explore_filter_sheet.dart';
import 'package:driver_mate/feature/home/view/widget/float_action_button_widget.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ExploreFilter _filter = ExploreFilter.initial;

  bool get _showRecommendation =>
      _filter.category == 'All' || _filter.category == 'Cars';

  void _openFilterSheet() async {
    final result = await showModalBottomSheet<ExploreFilter>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ExploreFilterSheet(initial: _filter),
    );
    if (result != null) setState(() => _filter = result);
  }

  void _openSearchPage() => MyNavigation.navigateTo(const ExploreSearchPage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ── Scaffold bg: slightly off from card surface for depth ─────────────
    final scaffoldBg = theme.brightness == Brightness.dark
        ? theme
              .scaffoldBackgroundColor // AppColors.black in dark
        : const Color(0xFFF8FAFC); // keep the light off-white

    final appBarBg =
        theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor;
    final iconColor = theme.iconTheme.color ?? theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: scaffoldBg,
      floatingActionButton: FloatActionButtonWidget(onPressed: () {}),
      appBar: AppBar(
        elevation: 0.4,
        scrolledUnderElevation: 0.4,
        backgroundColor: appBarBg,
        surfaceTintColor: appBarBg,
        title: Text(
          AppStrings.of(context).explore,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
            color: theme.colorScheme.onSurface, // white in dark, dark in light
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: iconColor),
            onPressed: _openSearchPage,
          ),
          IconButton(
            icon: Icon(Icons.tune, color: iconColor),
            onPressed: _openFilterSheet,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_showRecommendation) ...[
              const SizedBox(height: 2),
              const CustomRecommendationBanner(),
              const SizedBox(height: 24),
            ] else
              const SizedBox(height: 8),
            CustomCategoryChips(
              selected: _filter.category,
              onSelected: (cat) =>
                  setState(() => _filter = _filter.copyWith(category: cat)),
            ),
            const SizedBox(height: 28),
            ..._buildSections(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSections() {
    switch (_filter.category) {
      case 'Cars':
        return [
          CustomSectionHeader(title: AppStrings.of(context).featuredCars),
          const SizedBox(height: 16),
          CustomCarSlider(
            filter: _filter,
            onViewDetails: (CarItem car) => MyNavigation.navigateTo(
              CarDetailsPage(
                carName: car.title,
                carYear: car.subtitle,
                carType: car.category,
                carDescription: car.details,
                carImagePath: car.image,
                isNew: car.isNew,
              ),
            ),
          ),
        ];
      case 'Maintenance':
        return [CustomMaintenanceList(filter: _filter)];
      case 'Tips':
        return [const CustomTipsFeed()];
      case 'All':
      default:
        return [
          CustomSectionHeader(title: AppStrings.of(context).featuredCars),
          const SizedBox(height: 16),
          CustomCarSlider(
            filter: _filter,
            onViewDetails: (car) => MyNavigation.navigateTo(
              CarDetailsPage(
                carName: car.title,
                carYear: car.subtitle,
                carType: car.category,
                carDescription: car.details,
                carImagePath: car.image,
                isNew: car.isNew,
              ),
            ),
          ),
          const SizedBox(height: 12),
          CustomSectionHeader(
            title: AppStrings.of(context).maintanenceNearService,
            showViewAll: false,
          ),
          const SizedBox(height: 16),
          CustomMaintenanceList(filter: _filter),
          const SizedBox(height: 12),
          CustomSectionHeader(
            title: AppStrings.of(context).carTipsAndNews,
            showViewAll: false,
          ),
          const SizedBox(height: 16),
          const CustomTipsFeed(),
        ];
    }
  }
}
