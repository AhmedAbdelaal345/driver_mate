import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
// import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/maintenance_cubit.dart';
import 'package:driver_mate/feature/maintance_booking/manager/state/maintenance_state.dart';
// import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/service_center_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMaintenanceList extends StatelessWidget {
  const CustomMaintenanceList({super.key, required this.filter});

  final ExploreFilter filter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceCubit, MaintenanceState>(
      builder: (context, state) {
        if (state is MaintenanceLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.cyanColor),
          );
        } else if (state is MaintenanceLoaded) {
          final items = state.centers
              .where((center) => filter.category == 'All')
              .toList();

          return Column(
            children: items
                .map(
                  (s) => Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                s.name,
                                style: const TextStyle(
                                  color: AppColors.veryDarkBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '${s.distance.toStringAsFixed(1)} km',
                              style: const TextStyle(
                                color: AppColors.blueText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            ...List.generate(
                              5,
                              (index) => Icon(
                                index < 4.5.floor()
                                    ? Icons.star
                                    : Icons.star_half,
                                color: const Color(0xFFFFBF00),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "4.5",
                              style: const TextStyle(
                                color: AppColors.veryDarkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cyanColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              // Navigate to booking page with center details
                              MyNavigation.navigateTo(
                                ServiceCenterPage(
                                  serviceCenterName: s.name,
                                  workingHours: s.workingHours,
                                  address: s.address,
                                  phoneNumber: s.phone,
                                  imagePath: s.imagePath,
                                  serviceProvided: s.services,
                                  holiday: "Friday",
                                ),
                              );
                            },
                            child:  Text(
                              AppStrings.of(context).bookNow,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        } else if (state is MaintenanceError) {
          return Center(child: Text(state.error));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
