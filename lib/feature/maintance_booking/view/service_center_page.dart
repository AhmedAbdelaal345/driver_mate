import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:driver_mate/feature/booking_details/view/book_appointment.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/available_service_chip.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/hero_image_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/info_row_widget.dart';
import 'package:flutter/material.dart';

class ServiceCenterPage extends StatefulWidget {
  const ServiceCenterPage({
    super.key,
    this.serviceCenterName,
    this.imagePath,
    this.address,
    this.workingHours,
    this.phoneNumber,
    this.holiday,
    this.serviceProvided,
  });
  final String? serviceCenterName;
  final String? imagePath;
  final String? address;
  final String? workingHours;
  final String? phoneNumber;
  final String? holiday;
  final List<String>? serviceProvided;

  @override
  State<ServiceCenterPage> createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          AppConstants.serviceCenter,
          style: AppStyle.appBarTitle,
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Image Section
            HeroImageSection(),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * 0.05,
                vertical: SizeConfig.height(context) * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Center Title and Rating
                  Text(
                    widget.serviceCenterName ??
                        AppConstants.autoCareServiceCenter,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: AppColors.orange),
                      const Icon(Icons.star, size: 16, color: AppColors.orange),
                      const Icon(Icons.star, size: 16, color: AppColors.orange),
                      const Icon(Icons.star, size: 16, color: AppColors.orange),
                      const Icon(
                        Icons.star_border,
                        size: 16,
                        color: AppColors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppConstants.rating48,
                        style: AppStyle.boldSmallText.copyWith(
                          fontSize: AppFontSize.f12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppConstants.reviews234,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f11,
                          color: AppColors.iconGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Address Section
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    title: AppConstants.address,
                    subtitle: widget.address ?? AppConstants.fullAddress,
                    showAction: true,
                    actionIcon: Icons.navigation,
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Working Hours Section
                  InfoRow(
                    icon: Icons.access_time,
                    title: widget.workingHours ?? AppConstants.workingHours,
                    subtitle: "Holiday : ${widget.holiday}",
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Phone Section
                  InfoRow(
                    icon: Icons.phone_outlined,
                    title: AppConstants.phone,
                    subtitle: widget.phoneNumber ?? AppConstants.phoneNumber,
                    showAction: true,
                    actionIcon: null,
                    actionText: AppConstants.call,
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Available Services Section
                  Text(
                    AppConstants.availableServices,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AvailableServicesChips(
                    services:
                        widget.serviceProvided ??
                        [
                          AppConstants.oilChange,
                          AppConstants.tirePressure,
                          AppConstants.batteryStatus,
                          AppConstants.egTowing,
                        ],
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),

                  // Distance Info
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    decoration: BoxDecorationWidget.customBoxDecoration()
                        .copyWith(
                          color: AppColors.cyanColor.withValues(alpha: 0.1),
                        ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.cyanColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppConstants.distanceFromLocation,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f11,
                            color: AppColors.cyanColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: PrimaryElevatedButtonWidget(
            onPressed: () {
              // Navigate to Book Appoint Page
              MyNavigation.navigateTo(
                BookAppointmentPage(
                  serviceCenter: ServiceCenterModel(
                    address: widget.address,
                    serviceCenterName: widget.serviceCenterName,
                    phoneNumber: widget.phoneNumber,
                    workingHours: widget.workingHours,
                    holiday: widget.holiday,
                    price: 50,
                    servicesOffered: widget.serviceProvided,
                  ),
                ),
              );
            },
            buttonText: AppConstants.selectDateTime,
          ),
        ),
      ),
    );
  }
}
