import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/home/view/widget/container_title.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/avoid_mistake_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/how_to_step_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/maintence_header_card.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/what_you_need_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/why_mattar_section.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_item.dart';

class MaintenanceTipPage extends StatelessWidget {
  const MaintenanceTipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: const Text(
          AppConstants.maintenanceTip,
          style: AppStyle.appBarTitle,
        ),
        leading: const LeadingIcon(),
        actions: const [
          Icon(Icons.bookmark_border_outlined, color: AppColors.iconGrey),
          SizedBox(width: 12),
          Icon(Icons.share, color: AppColors.iconGrey),
          SizedBox(width: 12),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER CARD
              const MaintenanceHeaderCard(),

              const SizedBox(height: 20),

              /// WHY IT MATTERS
              const WhyItMattersSection(),

              const SizedBox(height: 20),

              /// WHAT YOU NEED
              const WhatYouNeedSection(),

              const SizedBox(height: 20),

              /// HOW TO DO IT
              const HowToStepsSection(),

              const SizedBox(height: 20),

              /// AVOID MISTAKES
              const AvoidMistakesSection(),

              const SizedBox(height: 20),
              Column(
                children: [
                  PrimaryElevatedButtonWidget(
                    buttonText: AppConstants.setReminder,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  _outlineButton(text: "Find Nearby Service Centers"),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "View More Tips →",
                      style: AppStyle.viewAll.copyWith(
                        color: AppColors.cyanColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// RELATED TIPS
              ContainerTitle(
                isAppear: true,
                onTap: () {},
                title: AppConstants.relatedTips,
                subTitle: AppConstants.seeAll,
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

              /// RELATED TIPS
              ContainerTitle(
                isAppear: true,
                onTap: () {},
                title: AppConstants.relatedTips,
                subTitle: AppConstants.seeAll,
              ),

              const TipItem(
                title: "When to rotate your tires",
                tag: "Maintenance",
                time: "4 min read",
              ),
              SizedBox(height: 12),
              const TipItem(
                title: "Understanding tire tread depth",
                tag: "Safety",
                time: "5 min read",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// buttons

  Widget _outlineButton({required String text}) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(text, style: AppStyle.boldSmallText),
      ),
    );
  }
}
