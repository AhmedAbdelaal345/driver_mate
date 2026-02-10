import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class ServiceCenterPage extends StatefulWidget {
  const ServiceCenterPage({super.key});

  @override
  State<ServiceCenterPage> createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  String _selectedTime = AppConstants.time1000;

  final List<String> _timeSlots = const [
    AppConstants.time900,
    AppConstants.time1000,
    AppConstants.time1100,
    AppConstants.time1200,
    AppConstants.time200,
    AppConstants.time300,
    AppConstants.time400,
    AppConstants.time500,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppConstants.maintenanceBooking,
          style: AppStyle.appBarTitle,
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.05,
            vertical: SizeConfig.height(context) * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ServiceCenterCard(),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.serviceDetails,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: const [
                    _DetailRow(
                      label: AppConstants.serviceType,
                      value: AppConstants.oilChangeOnly,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _DetailRow(
                      label: AppConstants.estimatedDuration,
                      value: AppConstants.duration45Min,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _DetailRow(
                      label: AppConstants.estimatedCost,
                      value: AppConstants.costRange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              _SectionHeader(
                icon: Icons.calendar_month_outlined,
                title: AppConstants.selectDate,
              ),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: AppConstants.pickDateHint,
                  hintStyle: AppStyle.hintStyle,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.iconGrey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.cyanColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              _SectionHeader(
                icon: Icons.access_time,
                title: AppConstants.selectTime,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _timeSlots.map((time) {
                  final isSelected = time == _selectedTime;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTime = time;
                      });
                    },
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.cyanColor
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.cyanColor
                              : AppColors.boarderWhiteColor,
                        ),
                      ),
                      child: Text(
                        time,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textGrey,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.03),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boarderWhiteColor,
                  disabledBackgroundColor: AppColors.boarderWhiteColor,
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.height(context) * 0.018,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                  ),
                ),
                child: Text(
                  AppConstants.bookNow,
                  style: AppStyle.boldSmallText.copyWith(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f13,
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

class _ServiceCenterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.cyanColor,
                  borderRadius: BorderRadius.circular(AppFontSize.f10),
                ),
                child: const Icon(
                  Icons.build,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.autoCare,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: AppColors.iconGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          AppConstants.distanceTime,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: AppColors.iconGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.star, size: 12, color: AppColors.orange),
                    SizedBox(width: 4),
                    Text(
                      AppConstants.rating48,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange,
                        fontFamily: AppFonts.fontArimo,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.smoothGreen,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  AppConstants.openNow,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f10,
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.containerGrey,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  AppConstants.recommendedForOil,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f10,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.serviceCenterNote,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f10,
              color: AppColors.iconGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.iconGrey,
              ),
            ),
          ),
          Text(
            value,
            style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f11),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyanColor, size: 16),
        const SizedBox(width: 6),
        Text(
          title,
          style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f12),
        ),
      ],
    );
  }
}
