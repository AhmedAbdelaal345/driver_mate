import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/cartips/view/car_tip_list_page.dart';
import 'package:driver_mate/feature/home/view/widget/container_title.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/maintenance_tip_model.dart';
import 'package:driver_mate/feature/maintance_booking/data/repo/maintenance_tip_repo.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_tip_cubit.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_tip_state.dart';
import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/avoid_mistake_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/how_to_step_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/maintence_header_card.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/what_you_need_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/why_mattar_section.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceTipPage extends StatelessWidget {
  const MaintenanceTipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MaintenanceTipCubit>(
      create: (context) => MaintenanceTipCubit(MaintenanceTipRepo())..loadTip(),

      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppStrings.of(context).maintenanceTip,
            style: AppStyle.appBarTitle.copyWith(
              color: Theme.of(context).appBarTheme.titleTextStyle?.color,
            ),
          ),
          leading: const LeadingIcon(),
          actions: [
            Icon(
              Icons.bookmark_border_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(width: 12),
            Icon(Icons.share, color: Theme.of(context).iconTheme.color),
            SizedBox(width: 12),
          ],
        ),

        body: BlocBuilder<MaintenanceTipCubit, MaintenanceTipState>(
          builder: (context, state) {
            if (state is MaintenanceTipLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is MaintenanceTipError) {
              return Center(child: Text(state.message));
            } else if (state is MaintenanceTipLoaded) {
              final MaintenanceTipModel tip = state.tip;
              // You can use the 'tip' data to populate your UI

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// HEADER CARD
                      MaintenanceHeaderCard(
                        labelText: tip.title,
                        hintText: tip.description,
                      ),

                      const SizedBox(height: 20),

                      /// WHY IT MATTERS
                      WhyItMattersSection(item: tip.whyItMatters),

                      const SizedBox(height: 20),

                      /// WHAT YOU NEED
                      WhatYouNeedSection(item: tip.whatYouNeed),

                      const SizedBox(height: 20),

                      /// HOW TO DO IT
                      HowToStepsSection(steps: tip.steps),

                      const SizedBox(height: 20),

                      /// AVOID MISTAKES
                      AvoidMistakesSection(mistakes: tip.mistakes),

                      const SizedBox(height: 20),
                      Column(
                        children: [
                          PrimaryElevatedButtonWidget(
                            buttonText: AppStrings.of(context).setReminder,
                            onPressed: () {
                              AppNotifier.show(
                                context,
                                "Reminder set successfully",

                                type: NotifierType.warning,
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          _outlineButton(
                            text: "Find Nearby Service Centers",
                            context: context,
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              MyNavigation.navigateTo(CarTipsListPage());
                            },
                            child: Center(
                              child: Text(
                                "View More Tips →",
                                style: AppStyle.viewAll.copyWith(
                                  color: AppColors.cyanColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// RELATED TIPS
                      ContainerTitle(
                        isAppear: true,
                        onTap: () {
                          MyNavigation.navigateTo(CarTipsListPage());
                        },
                        title: AppStrings.of(context).relatedTips,
                        subTitle: AppStrings.of(context).seeAll,
                      ),

                      const TipItem(
                        title: "When to rotate your tires",
                        tag: "Maintenance",
                        time: "4 min read",
                      ),
                      const SizedBox(height: 12),
                      const TipItem(
                        title: "Understanding tire tread depth",
                        tag: "Safety",
                        time: "5 min read",
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(); // Return an empty widget for any other state
            }
          },
        ),
      ),
    );
  }

  /// buttons

  Widget _outlineButton({required String text, required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          MyNavigation.navigateTo(BookMaintenancePage());
        },
        child: Text(
          text,
          style: AppStyle.boldSmallText.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
