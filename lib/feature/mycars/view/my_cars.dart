import 'dart:developer';

import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:driver_mate/feature/mycars/view/add_vehicle_page.dart';
import 'package:driver_mate/feature/mycars/view/widget/container_widget.dart';
import 'package:driver_mate/feature/mycars/view/widget/custom_container_bar.dart';
import 'package:driver_mate/feature/mycars/view/widget/vehical_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              log("navigate ");
              final cubit = context.read<VehicalCubit>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider.value(
                      value: cubit,
                      child: AddVehiclePage(),
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.add, color: AppColors.green),
          ),
        ],
      ),
      body: BlocBuilder<VehicalCubit, VehicalState>(
        builder: (context, state) {
          // loading
          if (state is InitialVehicalState ||
              state is LoadingVehicalState ||
              state is AddVehicalSuccessState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.cyanColor),
            );
          }

          if (state is ErrorVehicalState) {
            return Center(child: Text(state.error));
          }

          if (state is SuccessVehicalState) {
            final cars = state.data; // list of cars

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  /// top bar
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        CustomContainerBar(
                          numberOfAllVehical: cars.length.toString(),
                          numOfActive: cars.length.toString(),
                          numOfInService: "0",
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

                  /// list cars
                  if (cars.isEmpty)
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Text("No cars added yet"),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final car = cars[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: VehicleDetailCard(car: car),
                        );
                      }, childCount: cars.length),
                    ),

                  /// footer
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: ContainerWidget(
                          firstText: AppConstants.manageYourFleet,
                          secondText: AppConstants.addAllYourVehical,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
