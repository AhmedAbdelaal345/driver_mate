import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/mycars/view/widget/container_widget.dart';
import 'package:driver_mate/feature/mycars/view/widget/custom_container_bar.dart';
import 'package:driver_mate/feature/mycars/view/widget/vehical_detail_card.dart';
import 'package:flutter/material.dart';

class MyCars extends StatelessWidget {
  const MyCars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: Text(AppConstants.myCars, style: AppStyle.appBarTitle),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Logic to add a new vehicle
            },
            icon: const Icon(Icons.add, color: AppColors.green),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            // 1. Top Summary Bar (Static Header)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const CustomContainerBar(
                    numberOfAllVehical: "2",
                    numOfActive: "1",
                    numOfInService: "1",
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppConstants.yourVechical,
                    style: AppStyle.hintStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // 2. List of Vehicle Detail Cards (Scrollable)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Navigate to specific vehicle details or maintenance history
                      },
                      child: const VehicleDetailCard(),
                    ),
                  );
                },
                childCount: 2, // Set based on your actual data list length
              ),
            ),

            // 3. Footer / Call to Action Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Logic to open fleet management or external documentation
                  },
                  child: ContainerWidget(
                    firstText: AppConstants.manageYourFleet,
                    secondText: AppConstants.addAllYourVehical,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
