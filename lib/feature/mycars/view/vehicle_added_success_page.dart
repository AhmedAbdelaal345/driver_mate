import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:flutter/material.dart';

class VehicleAddedSuccessPage extends StatefulWidget {
  const VehicleAddedSuccessPage({super.key, required this.vehicle});

  final VechicleModel vehicle;

  @override
  State<VehicleAddedSuccessPage> createState() =>
      _VehicleAddedSuccessPageState();
}

class _VehicleAddedSuccessPageState extends State<VehicleAddedSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _checkAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.width(context);
    final height = SizeConfig.height(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => MyNavigation.navigateBack(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02),
              // Animated Success Icon
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.green,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.green.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: FadeTransition(
                      opacity: _checkAnimation,
                      child: const Icon(
                        Icons.check_rounded,
                        size: 60,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // Title
              Text(
                AppConstants.vehicleAddedTitle,
                style: AppStyle.labelStyle.copyWith(
                  fontSize: AppFontSize.f24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: height * 0.012),

              // Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text(
                  AppConstants.vehicleAddedSubtitle,
                  textAlign: TextAlign.center,
                  style: AppStyle.hintStyle.copyWith(
                    fontSize: AppFontSize.f14,
                    color: AppColors.textGrey,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),

              // Vehicle Summary Card
              _VehicleSummaryCard(vehicle: widget.vehicle),
              SizedBox(height: height * 0.025),

              // Info Callout
              _InfoCallout(
                text: AppConstants.vehicleAddedNote,
              ),
              SizedBox(height: height * 0.04),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    MyNavigation.navigateBack();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanColor,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    elevation: 2,
                    shadowColor: AppColors.cyanColor.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppFontSize.f12),
                    ),
                  ),
                  child: Text(
                    AppConstants.backToMyCars,
                    style: AppStyle.boldSmallText.copyWith(
                      color: AppColors.white,
                      fontSize: AppFontSize.f15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VehicleSummaryCard extends StatelessWidget {
  const _VehicleSummaryCard({required this.vehicle});

  final VechicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final brandModel = _getVehicleTitle();
    final yearText = vehicle.year?.toString() ?? "-";
    final plateText = _valueOrDash(vehicle.plateNumber);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f16,
      ).copyWith(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              // Vehicle Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.cyanColor,
                      AppColors.veryDarkBlue,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.directions_car_rounded,
                  color: AppColors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brandModel,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getVehicleSubtitle(),
                      style: AppStyle.hintStyle.copyWith(
                        fontSize: AppFontSize.f13,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            color: AppColors.containerGrey,
            thickness: 1,
          ),
          const SizedBox(height: 16),

          // Details
          _DetailItem(
            icon: Icons.calendar_today_outlined,
            label: AppConstants.manufacturingYear,
            value: yearText,
          ),
          const SizedBox(height: 16),
          _DetailItem(
            icon: Icons.confirmation_number_outlined,
            label: AppConstants.plateNumberLabel,
            value: plateText,
          ),
        ],
      ),
    );
  }

  String _getVehicleTitle() {
    final brand = (vehicle.brand ?? "").trim();
    final model = (vehicle.model ?? "").trim();
    if (brand.isEmpty && model.isEmpty) {
      return AppConstants.yourVehicle;
    }
    if (brand.isEmpty) return model;
    if (model.isEmpty) return brand;
    return "$brand $model";
  }

  String _getVehicleSubtitle() {
    if (vehicle.year == null) {
      return AppConstants.model;
    }
    return "${vehicle.year} ${AppConstants.model}";
  }

  String _valueOrDash(String? value) {
    final cleaned = value?.trim() ?? "";
    return cleaned.isEmpty ? "-" : cleaned;
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.cyanColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.cyanColor,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyle.hintStyle.copyWith(
                  fontSize: AppFontSize.f12,
                  color: AppColors.iconGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCallout extends StatelessWidget {
  const _InfoCallout({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(
        color: AppColors.cyanColor.withValues(alpha: 0.08),
        border: Border.all(
          color: AppColors.cyanColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: AppColors.cyanColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppStyle.regularSmallText.copyWith(
                fontSize: AppFontSize.f13,
                color: AppColors.cyanColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
