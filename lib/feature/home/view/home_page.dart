import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/ai/view/ai_voice_diagnosis_page.dart';
import 'package:driver_mate/feature/car_details/manager/cubit/car_details_cubit.dart';
import 'package:driver_mate/feature/car_details/manager/state/car_details_state.dart';
import 'package:driver_mate/feature/car_details/view/car_details_page.dart';
import 'package:driver_mate/feature/cartips/view/car_tip_list_page.dart';
import 'package:driver_mate/feature/cartips/view/cartips_page.dart';
import 'package:driver_mate/feature/emergency/view/emergency_assistance_page.dart';
import 'package:driver_mate/feature/explore/view/explore_search_page.dart';
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
import 'package:driver_mate/feature/home/view/wrapper_page.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_cubit.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_state.dart';
import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/maintenance_tip_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/service_center_page.dart';
import 'package:driver_mate/feature/maintance_history/view/maintance_history.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/view/add_vehicle_page.dart';
import 'package:driver_mate/feature/news/view/car_news_page.dart';
import 'package:driver_mate/feature/notification/view/notification_page.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_cubit.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
import 'package:driver_mate/feature/recommended_service/view/recommended_service_page.dart';
import 'package:driver_mate/feature/saved_item/view/saved_item_page.dart';
import 'package:driver_mate/feature/vehicle_status/view/vehicle_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context); // ← resolves fresh on every rebuild

    // ── Maintenance list (was static, now inside build) ──────────────────
    final List<MaintainanceContainerWidget> maintanceContainerList = [
      MaintainanceContainerWidget(
        onTap: () => MyNavigation.navigateTo(BookMaintenancePage()),
      ),
      MaintainanceContainerWidget(
        imagePath: AppImagePath.calenderIconPath,
        title: s.annual,
        subTitle: s.due2,
        statusContainerColor: AppColors.smoothcyanColor,
        statusText: s.upcoming,
        statusTextColor: AppColors.cyanColor,
        onTap: () => MyNavigation.navigateTo(BookMaintenancePage()),
      ),
      MaintainanceContainerWidget(
        imagePath: AppImagePath.stationIconPath,
        title: s.filterReplacement,
        subTitle: s.due3,
        statusContainerColor: AppColors.containerGrey,
        statusText: s.later,
        statusTextColor: AppColors.midGrey,
        onTap: () => MyNavigation.navigateTo(BookMaintenancePage()),
      ),
    ];

    // ── AI alerts (was static) ────────────────────────────────────────────
    final List<AiContainerWidget> aiAlerts = [
      AiContainerWidget(onTap: () {}),
      AiContainerWidget(
        title: s.tirePressureLow,
        action: s.findNearby,
        containerColor: AppColors.smoothcyanColor,
        iconColor: AppColors.babyBleu,
        icon: AppImagePath.warringIconPath,
        onTap: () {},
      ),
    ];

    // ── Horizontal car tips (was static) ─────────────────────────────────
    final List<CustomContainerWidget> homeTips = [
      CustomContainerWidget(
        title: s.carNews,
        subtitle: s.oilChangeDue,
        imagePath: AppImagePath.newsImagePath,
        isAppear: false,
        onTap: () => MyNavigation.navigateTo(CarNewsPage()),
      ),
      CustomContainerWidget(
        title: s.recommendedService,
        subtitle: s.oilChangeDue,
        imagePath: AppImagePath.container1ImagePath,
        isAppear: false,
        onTap: () => MyNavigation.navigateTo(RecommendedServicePage()),
      ),
      CustomContainerWidget(
        title: s.aiMaintenance,
        subtitle: s.checkTirePressure,
        imagePath: AppImagePath.container2ImagePath,
        isAppear: false,
        onTap: () => MyNavigation.navigateTo(MaintenanceTipPage()),
      ),
    ];

    // ── Vertical car tips (was already in build, keep here) ──────────────
    final List<CustomContainerWidget> carTips = [
      CustomContainerWidget(
        title: s.essentialCar,
        subtitle: s.minRead,
        imagePath: AppImagePath.firstImagePath,
        isAppear: true,
        readMore: s.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.10,
        onTap: () => MyNavigation.navigateTo(
          CarTipsPage(
            imagePath: AppImagePath.firstImagePath,
            hintText: s.maintenance,
            labelText: s.essentialCar,
          ),
        ),
      ),
      CustomContainerWidget(
        title: s.howToExtend,
        subtitle: s.minRead,
        imagePath: AppImagePath.secondImagePath,
        isAppear: true,
        readMore: s.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.10,
        onTap: () => MyNavigation.navigateTo(
          CarTipsPage(
            imagePath: AppImagePath.secondImagePath,
            hintText: s.maintenance,
            labelText: s.howToExtend,
          ),
        ),
      ),
      CustomContainerWidget(
        title: s.completeGuide,
        subtitle: s.minRead,
        imagePath: AppImagePath.thirdImagePath,
        isAppear: true,
        readMore: s.readMore,
        width: SizeConfig.width(context) * 0.213,
        height: SizeConfig.height(context) * 0.10,
        onTap: () => MyNavigation.navigateTo(
          CarTipsPage(
            imagePath: AppImagePath.thirdImagePath,
            hintText: s.maintenance,
            labelText: s.completeGuide,
          ),
        ),
      ),
    ];

    // ── Quick action grid ─────────────────────────────────────────────────
    final List<ContainerIconWidget> options = [
      ContainerIconWidget(
        icon: AppImagePath.micIconPath,
        text: s.aiVoice,
        onTap: () => MyNavigation.navigateTo(AiVoiceDiagnosisPage()),
      ),
      ContainerIconWidget(
        icon: AppImagePath.repairIconPath,
        text: s.maintenanceHistory,
        onTap: () => MyNavigation.navigateTo(MaintenanceHistory()),
      ),
      ContainerIconWidget(
        icon: AppImagePath.phoneIconPath,
        text: s.emergencyCall,
        onTap: () => MyNavigation.navigateTo(EmergencyAssistancePage()),
      ),
      ContainerIconWidget(
        icon: AppImagePath.plusIconPath,
        text: s.addVehicle,
        onTap: () => MyNavigation.navigateTo(
          BlocProvider.value(
            value: context.read<VehicalCubit>(),
            child: AddVehiclePage(),
          ),
        ),
      ),
    ];

    return Scaffold(
      floatingActionButton: FloatActionButtonWidget(
        onPressed: () => MyNavigation.navigateTo(WrapperPage(initialIndex: 1)),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          s.driverMate,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f18,
            color: Theme.of(
              context,
            ).colorScheme.onSurface, // ← was hardcoded AppColors.black
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => MyNavigation.navigateTo(ExploreSearchPage()),
            icon: Icon(Icons.search_outlined),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => MyNavigation.navigateTo(NotificationPage()),
            icon: const Icon(Icons.notifications),
          ),
          const SizedBox(width: 8),
          BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              EditProfileModel? profile;
              if (state is SuccessEditProfile) {
                profile = state.data;
              } else if (state is UpdateProfileSuccess)
                profile = state.data;

              return SizedBox(
                width: profile != null
                    ? 50
                    : SizeConfig.width(context) * 0.0485,
                height: profile != null
                    ? 50
                    : SizeConfig.height(context) * 0.071,
                child: InkWell(
                  onTap: () {
                    MyNavigation.navigateTo(WrapperPage(initialIndex: 4));
                  },
                  child: ContainerForIcon(
                    iconPath: profile?.image ?? AppImagePath.profileIconPath,
                  ),
                ),
              );
            },
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
                padding: EdgeInsets.zero,
                itemCount: options.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: SizeConfig.height(context) * 0.02,
                  crossAxisSpacing: SizeConfig.width(context) * 0.04,
                  childAspectRatio: 2.0,
                ),
                itemBuilder: (context, index) => options[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              StatusContainerWidget(
                onTap: () => MyNavigation.navigateTo(VehicleStatusPage()),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeTips.length, // ← was HomePage.carTips
                separatorBuilder: (_, __) =>
                    SizedBox(height: SizeConfig.height(context) * 0.015),
                itemBuilder: (_, index) => homeTips[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: maintanceContainerList
                    .length, // ← was HomePage.maintanceContainerList
                separatorBuilder: (_, __) =>
                    SizedBox(height: SizeConfig.height(context) * 0.015),
                itemBuilder: (_, index) => maintanceContainerList[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              ContainerTitle(
                onTap: () => MyNavigation.navigateTo(BookMaintenancePage()),
                title: s.nearByService,
                subTitle: s.seeMap,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              SizedBox(
                height: SizeConfig.height(context) * 0.29,
                child: BlocBuilder<MaintenanceCubit, MaintenanceState>(
                  builder: (context, state) {
                    if (state is MaintenanceLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface, // ← was hardcoded AppColors.black
                        ),
                      );
                    } else if (state is MaintenanceLoaded) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.centers.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: SizeConfig.width(context) * 0.02),
                        itemBuilder: (_, index) => ServiceSuppliedWidget(
                          distance: state.centers[index].distance.toString(),
                          title: state.centers[index].name,
                          first: s.tireService,
                          second: s.acService,
                          third: s.lastService,
                          onTap: () => MyNavigation.navigateTo(
                            BlocProvider.value(
                              value: context.read<MaintenanceCubit>(),
                              child: ServiceCenterPage(
                                address: state.centers[index].address,
                                imagePath: state.centers[index].imagePath,
                                phoneNumber: state.centers[index].phone,
                                serviceCenterName: state.centers[index].name,
                                workingHours: state.centers[index].workingHours,
                                serviceProvided: state.centers[index].services,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is MaintenanceError) {
                      return Center(child: Text(state.error));
                    }
                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ContainerTitle(title: s.aiAlerts, isAppear: false),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ListView.separated(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: aiAlerts.length, // ← was HomePage.aiAlerts
                separatorBuilder: (_, __) =>
                    SizedBox(height: SizeConfig.height(context) * 0.015),
                itemBuilder: (_, index) => aiAlerts[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              Row(
                children: [
                  Expanded(
                    child: ContainerItem(
                      onTap: () => MyNavigation.navigateTo(SavedItemsPage()),
                    ),
                  ),
                  SizedBox(width: SizeConfig.width(context) * 0.04),
                  Expanded(
                    child: ContainerItem(
                      title: s.recommendedMaintenance,
                      subTitle: s.continueWhere,
                      bottom: s.open,
                      containerColor: AppColors.purple.withValues(alpha: 0.1),
                      iconColor: AppColors.purple,
                      iconPath: AppImagePath.timingIconPath,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(
                title: s.carTips,
                subTitle: s.viewAll,
                isAppear: true,
                onTap: () => MyNavigation.navigateTo(CarTipsListPage()),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: carTips.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: SizeConfig.height(context) * 0.015),
                itemBuilder: (_, index) => carTips[index],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              ContainerTitle(
                title: s.recommendedForYou,
                subTitle: s.viewAll,
                onTap: () {},
              ),
              SizedBox(height: SizeConfig.height(context) * 0.031),
              SizedBox(
                height: SizeConfig.height(context) * 0.33,
                child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
                  builder: (context, state) {
                    if (state is CarDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is CarDetailsLoaded) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.carDetails.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: SizeConfig.width(context) * 0.04),
                        itemBuilder: (_, index) => RecommendedContainer(
                          title: state.carDetails[index].carName,
                          price: "\$${state.carDetails[index].price}",
                          image: state.carDetails[index].carImagePath,
                          subTitle: state.carDetails[index].carType,
                          onTap: () => MyNavigation.navigateTo(
                            BlocProvider.value(
                              value: context.read<CarDetailsCubit>(),
                              child: CarDetailsPage(
                                carName: state.carDetails[index].carName,
                                carType: state.carDetails[index].carType,
                                carDescription:
                                    state.carDetails[index].carDescription,
                                carImagePath:
                                    state.carDetails[index].carImagePath,
                                carYear: state.carDetails[index].carYear,
                                isNew: state.carDetails[index].isNew,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is CarDetailsError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
