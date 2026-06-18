import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/car_details/view/car_details_page.dart';
import 'package:driver_mate/feature/cartips/view/cartips_page.dart';
import 'package:driver_mate/feature/community/view/community_page.dart';
import 'package:driver_mate/feature/profile/view/help_center_page.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:driver_mate/feature/saved_item/view/widget/bottom_sheet_widget.dart';
import 'package:driver_mate/feature/saved_item/view/widget/saved_category_chip.dart';
import 'package:driver_mate/feature/saved_item/view/widget/saved_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedItemsPage extends StatefulWidget {
  const SavedItemsPage({super.key});

  @override
  State<SavedItemsPage> createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  String selected = "All";

  final categories = ["All", "Cars", "Services", "Articles", "Posts"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.of(context).savedItem, style: AppStyle.appBarTitle.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        )),
        actions: [
          IconButton(
            onPressed: () {
              showSavedSortSheet(context);
            },
            icon: const Icon(Icons.tune),
          ),
          // SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.043,
        ),
        child: BlocBuilder<SavedItemCubit, SavedItemState>(
          builder: (context, state) {
            if (state is SavedItemLoading) {
              return  Center(child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ));
            }

            if (state is SavedItemLoaded) {
              final List<SavedItemModel> items = state.items;

              final filteredItems = selected == "All"
                  ? items
                  : items.where((item) {
                      switch (selected) {
                        case "Cars":
                          return item.type == SavedType.car;
                        case "Services":
                          return item.type == SavedType.service;
                        case "Articles":
                          return item.type == SavedType.article;
                        case "Posts":
                          return item.type == SavedType.post;
                        default:
                          return true;
                      }
                    }).toList();

              return Column(
                children: [
                  const SizedBox(height: 16),

                  /// Top Info Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecorationWidget.customBoxDecoration(context)
                        ,
                    child: Row(
                      children: [
                        Icon(Icons.bookmark, color: Theme.of(context).primaryColor),
                        SizedBox(width: 12),
                        Text(
                          "You have ${filteredItems.length} saved items",
                          style: AppStyle.titleOfContainer,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories
                          .map(
                            (cat) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SavedCategoryChip(
                                label: cat,
                                selected: selected == cat,
                                onTap: () {
                                  setState(() {
                                    selected = cat;
                                  });
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Items
                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.of(context).noSavedItems,
                              style: AppStyle.labelStyle.copyWith(
                                 color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          )
                        : filteredItems.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.of(context).noSavedItemsInCategory
                                  .replaceFirst('\$selected', selected),
                              style: AppStyle.labelStyle.copyWith(
                                 color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredItems.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, index) => InkWell(
                              onTap: () {
                                switch (filteredItems[index].type) {
                                  case SavedType.car:
                                    MyNavigation.navigateTo(
                                      CarDetailsPage(
                                        carName: filteredItems[index].title,
                                        carYear: filteredItems[index].year
                                            .toString(),
                                        carType: filteredItems[index].subtitle,
                                        carDescription:
                                            filteredItems[index].subtitle,
                                        carImagePath:
                                            filteredItems[index].image,
                                      ),
                                    );
                                  case SavedType.article:
                                    MyNavigation.navigateTo(
                                      CarTipsPage(
                                        imagePath: filteredItems[index].image,
                                      ),
                                    );
                                  case SavedType.service:
                                    MyNavigation.navigateTo(HelpCenterPage());
                                    break;
                                  case SavedType.post:
                                    //TODO:Here we will replace this page with post details page
                                    MyNavigation.navigateTo(
                                      CommunityPage(),
                                    );
                                    break;
                                }
                              },
                              child: SavedItemCard(item: filteredItems[index]),
                            ),
                          ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
