import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/ai/view/ai_voice_diagnosis_page.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/emergency/view/emergency_assistance_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:driver_mate/feature/maintance_history/view/maintance_history.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/view/add_vehicle_page.dart';

import 'package:driver_mate/feature/mycars/view/widget/danger_zone_widget.dart';
import 'package:driver_mate/feature/mycars/view/widget/quick_action_item.dart';
import 'package:driver_mate/feature/mycars/view/widget/service_history_item.dart';
import 'package:driver_mate/feature/mycars/view/widget/service_info_card.dart';
import 'package:driver_mate/feature/mycars/view/widget/vehical_header_card.dart';
import 'package:flutter/material.dart';

class DailyCarDetailsPage extends StatelessWidget {
  const DailyCarDetailsPage({super.key, required this.vehicle});

  final VechicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            AppConstants.myDailyDriver,
            style: AppStyle.appBarTitle,
          ),
          leading: const LeadingIcon(),
          actions: [
            IconButton(
              onPressed: () {
                // TODO: Navigate to edit vehicle
                MyNavigation.navigateTo(
                  AddVehiclePage(isEditPage: true, vehicle: vehicle),
                );
              },
              icon: const Icon(Icons.edit_outlined, color: AppColors.iconGrey),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle Header Card
              VehicleHeaderCard(vehicle: vehicle),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context) * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.height(context) * 0.02),

                    // Service Info Cards
                    _ServiceInfoSection(vehicle: vehicle),
                    SizedBox(height: SizeConfig.height(context) * 0.03),

                    // Quick Actions Section
                    _SectionTitle(title: AppConstants.quickActions),
                    const SizedBox(height: 16),
                    _QuickActionsSection(),
                    SizedBox(height: SizeConfig.height(context) * 0.03),

                    // Recent History Section
                    _RecentHistoryHeader(),
                    const SizedBox(height: 16),
                    _RecentHistoryList(),
                    SizedBox(height: SizeConfig.height(context) * 0.03),

                    // Danger Zone
                    const _SectionTitle(title: AppConstants.dangerZone),
                    const SizedBox(height: 16),
                    DangerZoneWidget(
                      onRemoveVehicle: () {
                        _showRemoveVehicleDialog(context);
                      },
                    ),
                    SizedBox(height: SizeConfig.height(context) * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRemoveVehicleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppConstants.removeVehicleTitle,
          style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f16),
        ),
        content: Text(
          AppConstants.removeVehicleMessage,
          style: AppStyle.containerSubtitle.copyWith(
            fontSize: AppFontSize.f13,
            color: AppColors.textGrey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppConstants.cancel,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f13,
                color: AppColors.textGrey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement remove vehicle logic
              Navigator.pop(context);
              Navigator.pop(context); // Go back to previous screen
            },
            child: Text(
              AppConstants.remove,
              style: AppStyle.boldSmallText.copyWith(
                fontSize: AppFontSize.f13,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceInfoSection extends StatelessWidget {
  const _ServiceInfoSection({required this.vehicle});

  final VechicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ServiceInfoCard(
            icon: Icons.calendar_today_outlined,
            iconColor: AppColors.cyanColor,
            label: AppConstants.lastService,
            value: AppConstants.lastServiceDate,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ServiceInfoCard(
            icon: Icons.warning_amber_outlined,
            iconColor: AppColors.orange,
            label: AppConstants.nextService,
            value: AppConstants.nextServiceDate,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ServiceInfoCard(
            icon: Icons.speed_outlined,
            iconColor: AppColors.green,
            label: AppConstants.mileage,
            value: '${vehicle.millAge?.toStringAsFixed(0) ?? '0'} km',
          ),
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuickActionItem(
          icon: Icons.qr_code_scanner_outlined,
          iconColor: AppColors.cyanColor,
          title: AppConstants.runAIScan,
          subtitle: AppConstants.runAIScanDescription,
          trailing: Icons.show_chart,
          onTap: () {
            // TODO: Navigate to AI Scan
            MyNavigation.navigateTo(const AiVoiceDiagnosisPage());
          },
        ),
        const SizedBox(height: 12),
        QuickActionItem(
          icon: Icons.event_note_outlined,
          iconColor: AppColors.veryDarkBlue,
          title: AppConstants.bookMaintenance,
          subtitle: AppConstants.bookMaintenanceDescription,
          trailing: Icons.build_outlined,
          onTap: () {
            // TODO: Navigate to Book Maintenance
            MyNavigation.navigateTo(const BookMaintenancePage());
          },
        ),
        const SizedBox(height: 12),
        QuickActionItem(
          icon: Icons.phone_outlined,
          iconColor: AppColors.red,
          title: AppConstants.emergencyHelp,
          subtitle: AppConstants.emergencyHelpDescription,
          trailing: Icons.warning_amber_outlined,
          onTap: () {
            // TODO: Navigate to Emergency Help
            MyNavigation.navigateTo(const EmergencyAssistancePage());
          },
        ),
        const SizedBox(height: 12),
        QuickActionItem(
          icon: Icons.history_outlined,
          iconColor: AppColors.iconGrey,
          title: AppConstants.viewMaintenanceHistory,
          subtitle: AppConstants.viewMaintenanceHistoryDescription,
          trailing: Icons.description_outlined,
          onTap: () {
            // TODO: Navigate to Full Maintenance History
            MyNavigation.navigateTo(const MaintenanceHistory());
          },
        ),
      ],
    );
  }
}

class _RecentHistoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _SectionTitle(title: AppConstants.recentHistory),
        TextButton(
          onPressed: () {
            // TODO: Navigate to full history
          },
          child: Text(
            AppConstants.viewAll,
            style: AppStyle.viewAll.copyWith(fontSize: AppFontSize.f12),
          ),
        ),
      ],
    );
  }
}

class _RecentHistoryList extends StatelessWidget {
  // Mock data - replace with actual data from your repository
  final List<Map<String, dynamic>> _historyItems = const [
    {
      'title': 'Oil Change & Filter',
      'date': 'Jan 15, 2026',
      'serviceCenter': 'Al-Jazirah Auto Service',
      'cost': 'SAR 250',
      'status': 'Completed',
    },
    {
      'title': 'Brake Pad Replacement',
      'date': 'Dec 20, 2025',
      'serviceCenter': 'Premium Car Care',
      'cost': 'SAR 850',
      'status': 'Completed',
    },
    {
      'title': 'Tire Rotation',
      'date': 'Nov 10, 2025',
      'serviceCenter': 'Quick Service Center',
      'cost': 'SAR 180',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _historyItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ServiceHistoryItem(
            title: item['title'],
            date: item['date'],
            serviceCenter: item['serviceCenter'],
            cost: item['cost'],
            status: item['status'],
            onTap: () {
              // TODO: Navigate to service detail
            },
          ),
        );
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppStyle.boldSmallText.copyWith(
        fontSize: AppFontSize.f11,
        color: AppColors.iconGrey,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
