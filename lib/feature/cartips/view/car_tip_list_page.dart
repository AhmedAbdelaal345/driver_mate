import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/helper/saved_item_function.dart';
import 'package:driver_mate/core/helper/saved_type_helper.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/cartips/manager/cubit/car_tip_list_cubit.dart';
import 'package:driver_mate/feature/cartips/manager/state/car_tip_list_state.dart';
import 'package:driver_mate/feature/cartips/view/cartips_page.dart';
import 'package:driver_mate/feature/cartips/view/widget/category_chip_model.dart';
import 'package:driver_mate/feature/cartips/view/widget/filter_bottom_sheet.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_card_widget.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarTipsListPage extends StatelessWidget {
  const CarTipsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CarTipsListBody();
  }
}

class _CarTipsListBody extends StatefulWidget {
  const _CarTipsListBody();

  @override
  State<_CarTipsListBody> createState() => _CarTipsListBodyState();
}

class _CarTipsListBodyState extends State<_CarTipsListBody> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      AppStrings.of(context).all,
      AppStrings.of(context).maintenance,
      AppStrings.of(context).safety,
      AppStrings.of(context).fuelEconomy,
      AppStrings.of(context).tires,
      AppStrings.of(context).brakes,
      AppStrings.of(context).engine,
      AppStrings.of(context).emergency,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).carTips,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () => showFilterBottomSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<CarTipListCubit, CarTipState>(
        builder: (context, tipState) {
          if (tipState is CarTipLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.cyanColor,
              ),
            );
          }

          if (tipState is CarTipError) {
            return Center(child: Text(tipState.message));
          }

          if (tipState is CarTipLoaded) {
            final tips = tipState.tip;

            final filteredTips = selectedCategory == "All"
                ? tips
                : tips
                    .where((tip) => tip.category == selectedCategory)
                    .toList();

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * 0.043,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  /// Vehicle Header — reads from VehicleCubit state properly
                  const _DailyVehicleHeader(),

                  const SizedBox(height: 16),

                  /// Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CategoryChip(
                            label: cat,
                            isSelected: selectedCategory == cat,
                            onTap: () {
                              setState(() {
                                selectedCategory = cat;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Tips
                  Expanded(
                    child: ListView.separated(
                      itemCount: filteredTips.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) => _TipListItem(
                        tip: filteredTips[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

/// Reads the first vehicle from VehicleCubit state — no direct field access.
class _DailyVehicleHeader extends StatelessWidget {
  const _DailyVehicleHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicalCubit, VehicalState>(
      builder: (context, state) {
        String headerText = "";

        if (state is SuccessVehicalState && state.data.isNotEmpty) {
          final first = state.data.first;
          headerText = "${first.brandName} ${first.modelName}";
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headerText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppStrings.of(context).carTipsSubtitle,
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Self-contained tip card that handles its own SavedItemCubit subscription.
/// This prevents the whole list from rebuilding when a single save-state changes.
class _TipListItem extends StatelessWidget {
  const _TipListItem({required this.tip});

  final dynamic tip; // keep your actual TipModel type here

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyNavigation.navigateTo(
          BlocProvider.value(
            value: context.read<SavedItemCubit>(),
            child: CarTipsPage(
              labelText: tip.title,
              hintText: tip.content,
              imagePath: tip.imageUrl,
            ),
          ),
        );
      },
      child: BlocBuilder<SavedItemCubit, SavedItemState>(
        builder: (context, state) {
          bool isSaved = false;
          if (state is SavedItemLoaded) {
            isSaved = state.items.any(
              (item) => item.title == tip.title,
            );
          }

          return TipCard(
            tip: tip,
            icon: isSaved == false
                ? Icons.bookmark_border_outlined
                : Icons.bookmark,
            onPressed: () {
              savedItemFunction(
                context,
                title: tip.title,
                subtitle: tip.content,
                image: tip.imageUrl,
                type: getSavedType(tip.category ?? "Maintenance"),
                readTime: "5 minutes",
                isSaved: isSaved,
              );
            },
          );
        },
      ),
    );
  }
}