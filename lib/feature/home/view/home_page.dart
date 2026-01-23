import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/home/view/widget/container_icon_widget.dart';
import 'package:driver_mate/feature/home/view/widget/coursal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<ContainerIconWidget> _items = [
      ContainerIconWidget(
        icon: AppImagePath.micIconPath,
        text: AppConstants.aiVoice,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.driverMate,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f18,
          ),
        ),
        leading: Row(
          children: [
            SizedBox(width: 8.0),
            Icon(Icons.directions_car, color: AppColors.iconGrey),
            // here we will replace it with the user profile picture
            SizedBox(width: 5.0),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: AppColors.iconGrey),
            ),
          ],
        ),
      ),
      body: Column(children: [CoursalWidget(),GridView.builder(
        shrinkWrap: true,
        itemCount: _items.length,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.02,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: SizeConfig.height(context) * 0.02,
          crossAxisSpacing: SizeConfig.width(context) * 0.04,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return _items[index];
        },
      ),]),
    );
  }
}
