import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/explore/view/explore_search_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/service_center_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/maintenance_map_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/service_center_card.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/view_toggle_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_cubit.dart';

import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_state.dart';

class BookMaintenancePage extends StatefulWidget {
  const BookMaintenancePage({super.key});

  @override
  State<BookMaintenancePage> createState() => _BookMaintenancePageState();
}

class _BookMaintenancePageState extends State<BookMaintenancePage> {
  bool _isMapView = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use real centers if loaded, otherwise fall back to static list

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          AppStrings.of(context).bookMaintenance,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
         leading: 
         LeadingIcon(),
        //  IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios, color: AppColors.iconGrey),
        // ),
        actions: [
          IconButton(
            onPressed: () => MyNavigation.navigateTo(ExploreSearchPage()),
            icon:  Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * 0.05,
              vertical: SizeConfig.height(context) * 0.01,
            ),
            child: ViewToggle(
              isMapView: _isMapView,
              onChanged: (v) => setState(() => _isMapView = v),
            ),
          ),

          Expanded(
            child: BlocBuilder<MaintenanceCubit, MaintenanceState>(
              builder: (context, state) {
                if (state is MaintenanceLoading) {
                  return  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }

                if (state is MaintenanceError) {
                  return Center(child: Text(state.error));
                }

                if (state is MaintenanceLoaded) {
                  return _isMapView
                      ? MaintenanceMapPage(centers: state.centers)
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width(context) * 0.05,
                            vertical: SizeConfig.height(context) * 0.01,
                          ),
                          itemCount: state.centers.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            final center = state.centers[index];

                            return ServiceCenterCard(
                              center: ServiceCenter(
                                name: center.name,
                                distance:
                                    '${(center.distance / 1000).toStringAsFixed(1)} km',
                                rating: '4.5',
                                reviews: '(120)',
                                status: AppStrings.of(context).openNow,
                                services: center.services,
                                onTap: () {
                                  MyNavigation.navigateTo(
                                    ServiceCenterPage(
                                      serviceCenterName: center.name,
                                      address: center.address,
                                      phoneNumber: center.phone,
                                      workingHours: center.workingHours,
                                      serviceProvided: center.services,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Static fallback list (your original data)
  // late final List<ServiceCenter> _staticCenters = [
  //   ServiceCenter(
  //     name: "AutoCare Service Center",
  //     distance: "1.2 km",
  //     rating: "4.8",
  //     reviews: "(234)",
  //     status: AppConstants.openNow,
  //     services: ["Oil Change", "Brake Service", "Diagnostics"],
  //     onTap: () {
  //       MyNavigation.navigateTo(
  //         ServiceCenterPage(
  //           serviceCenterName: "AutoCare Service Center",
  //           address: "123 Auto Street, Cityville",
  //           holiday: "Closed on Sundays",
  //           phoneNumber: "+1 (555) 123-4567",
  //           serviceProvided: ["Oil Change", "Brake Service", "Diagnostics"],
  //           imagePath: AppImagePath.carImagePath,
  //           workingHours: "Mon-Sat: 8am-6pm, Sun: Closed",
  //         ),
  //       );
  //     },
  //   ),
  //   ServiceCenter(
  //     name: "QuickFix Auto Works",
  //     distance: "2.5 km",
  //     rating: "4.6",
  //     reviews: "(189)",
  //     status: AppConstants.openNow,
  //     services: ["Engine", "Tire Service", "AC Service"],
  //     onTap: () {
  //       MyNavigation.navigateTo(
  //         ServiceCenterPage(
  //           serviceCenterName: "QuickFix Auto Works",
  //           address: "456 Repair Ave, Townsville",
  //           holiday: "Closed on Sundays",
  //           phoneNumber: "+1 (555) 987-6543",
  //           serviceProvided: ["Engine", "Tire Service", "AC Service"],
  //           imagePath: AppImagePath.carImagePath,
  //           workingHours: "Mon-Sat: 9am-5pm, Sun: Closed",
  //         ),
  //       );
  //     },
  //   ),
  //   ServiceCenter(
  //     name: "ProTech Motors",
  //     distance: "3.8 km",
  //     rating: "4.9",
  //     reviews: "(312)",
  //     status: AppConstants.closed,
  //     services: ["Full Service", "Body Work", "Electrical"],
  //     onTap: () {
  //       MyNavigation.navigateTo(
  //         ServiceCenterPage(
  //           serviceCenterName: "ProTech Motors",
  //           address: "456 Repair Ave, Townsville",
  //           holiday: "Closed on Sundays",
  //           phoneNumber: "+1 (555) 987-6543",
  //           serviceProvided: ["Full Service", "Body Work", "Electrical"],
  //           imagePath: AppImagePath.bmwCarImagePath,
  //           workingHours: "Mon-Sat: 9am-5pm, Sun: Closed",
  //         ),
  //       );
  //     },
  //   ),
  //   ServiceCenter(
  //     name: "SpeedCare Garage",
  //     distance: "4.2 km",
  //     rating: "4.5",
  //     reviews: "(156)",
  //     status: AppConstants.openNow,
  //     services: ["Oil Change", "Suspension", "Battery"],
  //     onTap: () {
  //       MyNavigation.navigateTo(
  //         ServiceCenterPage(
  //           serviceCenterName: "SpeedCare Garage",
  //           address: "789 Service Rd, Villagetown",
  //           holiday: "Closed on Sundays",
  //           phoneNumber: "+1 (555) 555-1234",
  //           serviceProvided: ["Oil Change", "Suspension", "Battery"],
  //           imagePath: AppImagePath.carImagePath,
  //           workingHours: "Mon-Sat: 7am-7pm, Sun: Closed",
  //         ),
  //       );
  //     },
  //   ),
  // ];
}
