import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/home/view/widget/container_icon_widget.dart';
import 'package:driver_mate/feature/home/view/widget/coursal_widget.dart';
import 'package:driver_mate/feature/home/view/widget/custom_container_widget.dart';
import 'package:driver_mate/feature/home/view/widget/status_container_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<ContainerIconWidget> options = [
      ContainerIconWidget(
        icon: AppImagePath.micIconPath,
        text: AppConstants.aiVoice,
        // here we will add onTap functionality later
      ),
      ContainerIconWidget(
        icon: AppImagePath.phoneIconPath,
        text: AppConstants.emergencyCall,
      ),
      ContainerIconWidget(
        icon: AppImagePath.repairIconPath,
        text: AppConstants.maintanence,
      ),
      ContainerIconWidget(
        icon: AppImagePath.plusIconPath,
        text: AppConstants.add,
      ),
    ];
    const List<CustomContainerWidget> listItems = [
      CustomContainerWidget(
        title: AppConstants.latestCarNews,
        subtitle: AppConstants.electricVehicles,
        imagePath: AppImagePath.newsImagePath,
      ),
      CustomContainerWidget(
        title: AppConstants.recommendedService,
        subtitle: AppConstants.good,
        imagePath: AppImagePath.loginImagePath,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.driverMate,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: AppColors.textGrey),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppImagePath.profileIconPath),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.043,
          ),
          child: Column(
            children: [
              CoursalWidget(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                padding: EdgeInsets.symmetric(
                  // horizontal: SizeConfig.width(context) * 0.05,
                  vertical: SizeConfig.height(context) * 0.02,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: SizeConfig.height(context) * 0.02,
                  crossAxisSpacing: SizeConfig.width(context) * 0.04,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  return options[index];
                },
              ),
              StatusContainerWidget(),
              SizedBox(height: SizeConfig.height(context) * 0.0123),
              ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: SizeConfig.height(context) * 0.0123),
                itemBuilder: (context, index) {
                  return listItems[index];
                },
                itemCount: listItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
