import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/helper/saved_item_function.dart';
import 'package:driver_mate/core/helper/saved_type_helper.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/cartips/data/repo/car_tip_list_repo.dart';
import 'package:driver_mate/feature/cartips/manager/cubit/car_tip_list_cubit.dart';
import 'package:driver_mate/feature/cartips/manager/state/car_tip_list_state.dart';
import 'package:driver_mate/feature/cartips/view/cartips_page.dart';
import 'package:driver_mate/feature/cartips/view/widget/category_chip_model.dart';
import 'package:driver_mate/feature/cartips/view/widget/filter_bottom_sheet.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_card_widget.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarTipsListPage extends StatelessWidget {
  const CarTipsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarTipListCubit(CarTipLsitRepo())..loadTip(),
      child: const _CarTipsListBody(),
    );
  }
}

class _CarTipsListBody extends StatefulWidget {
  const _CarTipsListBody();

  @override
  State<_CarTipsListBody> createState() => _CarTipsListBodyState();
}

class _CarTipsListBodyState extends State<_CarTipsListBody> {
  String selectedCategory = "All";

  final List<String> categories = [
    "All",
    "Maintenance",
    "Safety",
    "Fuel Economy",
    "Tires",
    "Brakes",
    "Engine",
    "Emergency",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👈 هنا مكانه الصح
      appBar: AppBar(
        title: const Text("Car Tips"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilterBottomSheet(context),
          ),
        ],
      ),
      body: BlocBuilder<CarTipListCubit, CarTipState>(
        builder: (context, state) {
          if (state is CarTipLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CarTipError) {
            return Center(child: Text(state.message));
          }

          if (state is CarTipLoaded) {
            final tips = state.tip;

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

                  /// Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.veryDarkBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Toyota Camry 2024",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tips and maintenance guidance for your car",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),

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
                      itemBuilder: (_, index) => InkWell(
                        onTap: () {
                          MyNavigation.navigateTo(
                            BlocProvider.value(
                              value: context.read<SavedItemCubit>(),
                              child: CarTipsPage(
                                labelText: filteredTips[index].title,
                                hintText: filteredTips[index].description,
                                assetName: filteredTips[index].image,
                              ),
                            ),
                          );
                        },
                        child: BlocBuilder<SavedItemCubit, SavedItemState>(
                          builder: (context, state) {
                            bool isSaved = false;
                            if (state is SavedItemLoaded) {
                              isSaved = state.items.any(
                                (item) =>
                                    item.title == filteredTips[index].title,
                              );
                            }
                            return TipCard(
                              tip: filteredTips[index],
                              icon: isSaved == false
                                  ? Icons.bookmark_border_outlined
                                  : Icons.bookmark,
                              onPressed: () {
                                //TODO:Here we will added item in save List and change state for is pressed
                                savedItemFunction(
                                  context,
                                  title: filteredTips[index].title,
                                  subtitle: filteredTips[index].description,
                                  image: filteredTips[index].image,
                                  type: getSavedType(
                                    filteredTips[index].category,
                                  ),
                                  readTime: "5 minutes",
                                  isSaved: isSaved,
                                );
                              },
                            );
                          },
                        ),
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
