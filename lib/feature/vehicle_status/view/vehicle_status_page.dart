import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class VehicleStatusPage extends StatelessWidget {
  const VehicleStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.vehicleStatus, style: AppStyle.appBarTitle),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.vehicleName,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.smoothGreen,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 6,
                                color: AppColors.green,
                              ),
                              SizedBox(width: 4),
                              Text(
                                AppConstants.good,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green,
                                  fontFamily: AppFonts.fontArimo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppConstants.lastUpdated,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: AppColors.iconGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.vehicleStatusSummary,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.healthMetrics,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              _MetricTile(
                icon: Icons.monitor_heart,
                iconColor: AppColors.green,
                title: AppConstants.engineHealth,
                status: AppConstants.good,
                statusColor: AppColors.green,
                subtitle: AppConstants.engineHealthSub,
              ),
              const SizedBox(height: 10),
              _MetricTile(
                icon: Icons.battery_charging_full,
                iconColor: AppColors.orange,
                title: AppConstants.batteryHealth,
                status: AppConstants.attention,
                statusColor: AppColors.orange,
                subtitle: AppConstants.batteryHealthSub,
              ),
              const SizedBox(height: 10),
              _MetricTile(
                icon: Icons.tire_repair,
                iconColor: AppColors.babyBleu,
                title: AppConstants.tirePressure,
                status: AppConstants.good,
                statusColor: AppColors.green,
                subtitle: AppConstants.tirePressureSub,
              ),
              const SizedBox(height: 10),
              _MetricTile(
                icon: Icons.local_gas_station,
                iconColor: AppColors.yellow,
                title: AppConstants.oilLife,
                status: AppConstants.oilPercent,
                statusColor: AppColors.orange,
                subtitle: AppConstants.oilLifeSub,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.quickActions,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _QuickAction(
                    icon: Icons.auto_awesome,
                    label: AppConstants.runAiScan,
                    color: AppColors.perpule,
                  ),
                  _QuickAction(
                    icon: Icons.build,
                    label: AppConstants.book,
                    color: AppColors.babyBleu,
                  ),
                  _QuickAction(
                    icon: Icons.lightbulb_outline,
                    label: AppConstants.seeTips,
                    color: AppColors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String status;
  final Color statusColor;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppStyle.boldSmallText.copyWith(
                          fontSize: AppFontSize.f12,
                        ),
                      ),
                    ),
                    Text(
                      status,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppStyle.containerSubtitle.copyWith(
            fontSize: AppFontSize.f10,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
