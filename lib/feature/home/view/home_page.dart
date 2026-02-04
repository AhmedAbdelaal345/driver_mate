import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/ai/view/ai_voice_diagnosis_page.dart';
import 'package:driver_mate/feature/ai/view/widget/quick_record_sheet.dart';
import 'package:driver_mate/feature/emergency/view/emergency_assistance_page.dart';
import 'package:driver_mate/feature/home/view/widget/ai_container_widget.dart';
import 'package:driver_mate/feature/home/view/widget/container_icon_widget.dart';
import 'package:driver_mate/feature/home/view/widget/container_item.dart';
import 'package:driver_mate/feature/home/view/widget/container_title.dart';
import 'package:driver_mate/feature/home/view/widget/coursal_widget.dart';
import 'package:driver_mate/feature/home/view/widget/custom_container_widget.dart';
import 'package:driver_mate/feature/home/view/widget/float_action_button_widget.dart';
import 'package:driver_mate/feature/home/view/widget/maintainance_container_widget.dart';
import 'package:driver_mate/feature/home/view/widget/recommended_container.dart';
import 'package:driver_mate/feature/home/view/widget/service_supplied_widget.dart';
import 'package:driver_mate/feature/home/view/widget/status_container_widget.dart';
import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:driver_mate/feature/mycars/view/add_vehicle_page.dart';
import 'package:driver_mate/feature/notification/view/notification_page.dart';
import 'package:driver_mate/feature/vehicle_status/view/vehicle_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static final List<ContainerIconWidget> options = [
    ContainerIconWidget(
      icon: AppImagePath.micIconPath,
      text: AppConstants.aiVoice,
      onTap: () {
        MyNavigation.navigateTo(AiVoiceDiagnosisPage());
      },
      // here we will add onTap functionality later
    ),
    ContainerIconWidget(
      icon: AppImagePath.phoneIconPath,
      text: AppConstants.emergencyCall,
      onTap: () {
        MyNavigation.navigateTo(EmergencyAssistancePage());
      },
    ),
    ContainerIconWidget(
      icon: AppImagePath.repairIconPath,
      text: AppConstants.maintanence,
      onTap: () {
        MyNavigation.navigateTo(BookMaintenancePage());
      },
    ),
    ContainerIconWidget(
      icon: AppImagePath.plusIconPath,
      text: AppConstants.add,
      onTap: () {
        MyNavigation.navigateTo(AddVehiclePage());
      },
    ),
  ];
  static const List<MaintainanceContainerWidget> maintanceContainerList = [
    MaintainanceContainerWidget(),
    MaintainanceContainerWidget(
      imagePath: AppImagePath.calenderIconPath,
      title: AppConstants.annual,
      subTitle: AppConstants.due2,
      statusContainerColor: AppColors.smoothcyanColor,
      statusText: AppConstants.upcoming,
      statusTextColor: AppColors.cyanColor,
    ),

    MaintainanceContainerWidget(
      imagePath: AppImagePath.stationIconPath,
      title: AppConstants.filterRepalcement,
      subTitle: AppConstants.due3,
      statusContainerColor: AppColors.containerGrey,
      statusText: AppConstants.later,
      statusTextColor: AppColors.midGrey,
    ),
  ];

  static const List<ServiceSuppliedWidget> service = [
    ServiceSuppliedWidget(
      first: "Tair Repaire",
      second: "help1",
      third: "help3",
    ),
    ServiceSuppliedWidget(
      title: "QuickFix Auto Center",
      first: "AC Repair",
      second: "help1",
      third: "help2",
    ),
  ];

  static final List<AiContainerWidget> aiAlerts = [
    AiContainerWidget(onTap: () {}),
    AiContainerWidget(
      title: AppConstants.tirePressureLow,
      action: AppConstants.findNearby,
      containerColor: AppColors.smoothcyanColor,
      iconColor: AppColors.babyBleu,
      icon: AppImagePath.warringIconPath,
      onTap: () {},
    ),
  ];
  static const List<RecommendedContainer> recommendedCarList = [
    RecommendedContainer(),
    RecommendedContainer(
      title: "Honda Accord 2023",
      price: "\$26,500",
      image: AppImagePath.tairImagePath,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // const List<CustomContainerWidget> listItems = [
    //   CustomContainerWidget(
    //     title: AppConstants.latestCarNews,
    //     subtitle: AppConstants.electricVehicles,
    //     imagePath: AppImagePath.newsImagePath,
    //   ),
    //   CustomContainerWidget(
    //     title: AppConstants.recommendedService,
    //     subtitle: AppConstants.oilChange,
    //     imagePath: AppImagePath.loginImagePath,
    //   ),
    //   CustomContainerWidget(
    //     title: AppConstants.aiMaintenance,
    //     subtitle: AppConstants.checkTirePressure,
    //     imagePath: AppImagePath.camryCarImagePath,
    //   ),
    // ];
    final List<CustomContainerWidget> carTips = [
      CustomContainerWidget(
        title: AppConstants.essentialCar,
        subtitle: AppConstants.minRead,
        imagePath: AppImagePath.firstImagePath,
        isAppear: true,
        readMore: AppConstants.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.14,
      ),
      CustomContainerWidget(
        title: AppConstants.howToExtend,
        subtitle: AppConstants.minRead,
        imagePath: AppImagePath.secondImagePath,
        isAppear: true,
        readMore: AppConstants.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.14,
      ),
      CustomContainerWidget(
        title: AppConstants.completeGuide,
        subtitle: AppConstants.minRead,
        imagePath: AppImagePath.thirdImagePath,
        isAppear: true,
        readMore: AppConstants.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.14,
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatActionButtonWidget(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.white,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => const QuickRecordSheet(),
          );
        },
      ),
      appBar: AppBar(
        title: Text(
          AppConstants.driverMate,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyNavigation.navigateTo(NotificationPage());
            },
            icon: const Icon(Icons.notifications, color: AppColors.textGrey),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: SvgPicture.asset(AppImagePath.profileIconPath),
            ),
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
              SizedBox(height: SizeConfig.height(context) * 0.03),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero, // REMOVE default padding
                itemCount: options.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: SizeConfig.height(context) * 0.02,
                  crossAxisSpacing: SizeConfig.width(context) * 0.04,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) => options[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),

              StatusContainerWidget(
                onTap: () {
                  MyNavigation.navigateTo(VehicleStatusPage());
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                padding: EdgeInsets.zero, // REMOVE default padding
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: aiAlerts.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: SizeConfig.height(context) * 0.015),
                itemBuilder: (context, index) => aiAlerts[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return maintanceContainerList[index];
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.height(context) * 0.015);
                },
                itemCount: maintanceContainerList.length,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              ContainerTitle(
                onTap: () {
                  //here  we will add the functionality for the item
                },
                title: AppConstants.nearByService,
                subTitle: AppConstants.seeMap,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),

              SizedBox(
                // Adjust this height based on your card design (usually between 250-300)
                height: SizeConfig.height(context) * 0.40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: service.length,
                  // Add some spacing between cards
                  separatorBuilder: (context, index) =>
                      SizedBox(width: SizeConfig.width(context) * 0.04),
                  itemBuilder: (context, index) => service[index],

                  // Add padding so the cards don't touch the screen edges
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ContainerTitle(title: AppConstants.aiAlerts, isAppear: false),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              ListView.separated(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: aiAlerts.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.height(context) * 0.015);
                },
                itemBuilder: (context, index) => aiAlerts[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              Row(
                children: [
                  Expanded(child: ContainerItem(onTap: () {})),
                  SizedBox(width: SizeConfig.width(context) * 0.04),
                  Expanded(
                    child: ContainerItem(
                      title: AppConstants.recentlyViewed,
                      subTitle: AppConstants.continueWhere,
                      bottom: AppConstants.open,
                      containerColor: AppColors.perpule.withValues(alpha: 0.1),
                      iconColor: AppColors.perpule,
                      iconPath: AppImagePath.timingIconPath,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(
                title: AppConstants.carTips,
                subTitle: AppConstants.viewAll,
                isAppear: true,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConfig.height(context) * 0.015);
                },
                itemBuilder: (context, index) {
                  return carTips[index];
                },
                itemCount: carTips.length,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(
                title: AppConstants.recommendedForYou,
                subTitle: AppConstants.viewAll,
                onTap: () {
                  // here we will added the functionality
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              SizedBox(
                height: SizeConfig.height(context) * 0.33,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,

                  itemBuilder: (context, index) {
                    return recommendedCarList[index];
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: SizeConfig.width(context) * 0.015),
                  itemCount: recommendedCarList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
