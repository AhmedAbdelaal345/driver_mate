import 'package:driver_mate/core/helper/saved_item_function.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/car_details/view/widget/hero_section_widget.dart';
import 'package:driver_mate/feature/car_details/view/widget/high_list_widget.dart';
import 'package:driver_mate/feature/car_details/view/widget/maintence_list.dart';
import 'package:driver_mate/feature/car_details/view/widget/section_title_widget.dart';
import 'package:driver_mate/feature/car_details/view/widget/specification_gride.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({
    super.key,
    required this.carName,
    required this.carYear,
    required this.carType,
    required this.carDescription,
    required this.carImagePath,
    this.isNew = false,
  });

  final String carName;
  final String carYear;
  final String carType;
  final String carDescription;
  final String carImagePath;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    bool isSaved = false;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          AppStrings.of(context).carDetails,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            HeroImageSectionWidget(imagePath: carImagePath, isNew: isNew),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * 0.05,
                vertical: SizeConfig.height(context) * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Title
                  Text(
                    '$carYear $carName',
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    carType,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f14,
                      color: AppColors.cyanColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.of(context).carTagline,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    carDescription,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.03),

                  // Key Specifications Section
                  SectionTitle(title: AppStrings.of(context).keySpecifications),
                  const SizedBox(height: 16),
                  SpecificationsGrid(),
                  SizedBox(height: SizeConfig.height(context) * 0.03),

                  // Highlights Section
                  SectionTitle(title: AppStrings.of(context).highlights),
                  const SizedBox(height: 16),
                  HighlightsList(),
                  SizedBox(height: SizeConfig.height(context) * 0.03),

                  // Common Maintenance Section
                  SectionTitle(title: AppStrings.of(context).commonMaintenance),
                  const SizedBox(height: 16),
                  MaintenanceList(),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Action Buttons
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              BlocBuilder<SavedItemCubit, SavedItemState>(
                builder: (context, state) {
                  // bool isSaved = false;
                  if (state is SavedItemLoaded) {
                    isSaved = state.items.any((item) => item.title == carName);
                  }
                  return Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: isSaved
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).iconTheme.color!.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f12),
                        ),
                      ),
                      onPressed: () {
                        savedItemFunction(
                          context,
                          title: carName,
                          subtitle: "Year:$carYear \n Model:$carType ",
                          image: carImagePath,
                          type: SavedType.car,
                          year: carYear,
                          price: r" 250000 $",
                          isSaved: isSaved,
                        );
                      },
                      icon: Icon(
                        Icons.bookmark_border,
                        color: isSaved
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).iconTheme.color,
                      ),
                      label: Text(
                        AppStrings.of(context).save,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f13,
                          color: isSaved
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).iconTheme.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(
                      color: AppColors.iconGrey.withValues(alpha: 0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppFontSize.f12),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implement tips functionality
                  },
                  icon:  Icon(
                    Icons.menu_book_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
                    AppStrings.of(context).tips,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f13,
                      color: Theme.of(context).iconTheme.color,
                      fontWeight: FontWeight.w600,
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
