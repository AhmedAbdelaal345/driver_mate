import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_fonts.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/vehicle_status/view/widget/metric_tile.dart';
import 'package:driver_mate/feature/vehicle_status/view/widget/quick_action_widget.dart';
import 'package:flutter/material.dart';

class VehicleStatusPage extends StatelessWidget {
  const VehicleStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).vehicleStatus,
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.of(context).vehicleName,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
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
                            children: [
                              const Icon(
                                Icons.circle,
                                size: 6,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                AppStrings.of(context).good,
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
                          AppStrings.of(context).lastUpdated,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.of(context).vehicleStatusSummary,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppStrings.of(context).healthMetrics,
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              MetricTile(
                icon: Icons.monitor_heart,
                iconColor: AppColors.green,
                title: AppStrings.of(context).engineHealth,
                status: AppStrings.of(context).good,
                statusColor: AppColors.green,
                subtitle: AppStrings.of(context).engineHealthSub,
              ),
              const SizedBox(height: 10),
              MetricTile(
                icon: Icons.battery_charging_full,
                iconColor: AppColors.orange,
                title: AppStrings.of(context).batteryHealth,
                status: AppStrings.of(context).normal,
                statusColor: AppColors.orange,
                subtitle: AppStrings.of(context).batteryHealthSub,
              ),
              const SizedBox(height: 10),
              MetricTile(
                icon: Icons.tire_repair,
                iconColor: AppColors.babyBleu,
                title: AppStrings.of(context).tirePressure,
                status: AppStrings.of(context).good,
                statusColor: AppColors.green,
                subtitle: AppStrings.of(context).tirePressureSub,
              ),
              const SizedBox(height: 10),
              MetricTile(
                icon: Icons.local_gas_station,
                iconColor: AppColors.yellow,
                title: AppStrings.of(context).oilLife,
                status: AppStrings.of(context).oilPercent,
                statusColor: AppColors.orange,
                subtitle: AppStrings.of(context).oilLifeSub,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppStrings.of(context).quickActions,
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickAction(
                    icon: Icons.auto_awesome,
                    label: AppStrings.of(context).runAiScan,
                    color: Theme.of(context).textTheme.bodyMedium?.color??AppColors.grey,
                  ),
                  QuickAction(
                    icon: Icons.build,
                    label: AppStrings.of(context).book,
                    color: Theme.of(context).textTheme.bodyMedium?.color??AppColors.grey,
                  ),
                  QuickAction(
                    icon: Icons.lightbulb_outline,
                    label: AppStrings.of(context).seeTips,
                    color: Theme.of(context).textTheme.bodyMedium?.color??AppColors.grey,
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
