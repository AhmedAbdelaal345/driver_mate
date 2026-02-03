import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _maintenance = true;
  bool _offers = true;
  bool _aiAlerts = true;
  bool _emergency = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.notifications, style: AppStyle.appBarTitle),
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
              Text(
                AppConstants.notificationPreferences,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: [
                    _NotificationSwitchTile(
                      title: AppConstants.maintenanceReminders,
                      subtitle: AppConstants.maintenanceRemindersSub,
                      value: _maintenance,
                      onChanged: (value) {
                        setState(() {
                          _maintenance = value;
                        });
                      },
                    ),
                    Divider(color: AppColors.containerGrey),
                    _NotificationSwitchTile(
                      title: AppConstants.offersPromotions,
                      subtitle: AppConstants.offersPromotionsSub,
                      value: _offers,
                      onChanged: (value) {
                        setState(() {
                          _offers = value;
                        });
                      },
                    ),
                    Divider(color: AppColors.containerGrey),
                    _NotificationSwitchTile(
                      title: AppConstants.aiAlerts,
                      subtitle: AppConstants.aiAlertsSub,
                      value: _aiAlerts,
                      onChanged: (value) {
                        setState(() {
                          _aiAlerts = value;
                        });
                      },
                    ),
                    Divider(color: AppColors.containerGrey),
                    _NotificationSwitchTile(
                      title: AppConstants.emergencyUpdates,
                      subtitle: AppConstants.emergencyUpdatesSub,
                      value: _emergency,
                      onChanged: (value) {
                        setState(() {
                          _emergency = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              Text(
                AppConstants.schedule,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.cyanColor.withValues(alpha: 0.12),
                    child: const Icon(
                      Icons.access_time,
                      color: AppColors.cyanColor,
                      size: 18,
                    ),
                  ),
                  title: Text(
                    AppConstants.notificationSchedule,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                  subtitle: Text(
                    AppConstants.setQuietHours,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f11,
                      color: AppColors.iconGrey,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.iconGrey,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.containerGrey),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      color: AppColors.textGrey,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.notificationSettings,
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f12,
                              color: AppColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppConstants.notificationSettingsSub,
                            style: AppStyle.regularSmallText.copyWith(
                              fontSize: AppFontSize.f11,
                              color: AppColors.iconGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationSwitchTile extends StatelessWidget {
  const _NotificationSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f11,
          color: AppColors.iconGrey,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.cyanColor,
        activeTrackColor: AppColors.smoothcyanColor,
        inactiveThumbColor: AppColors.iconGrey,
        inactiveTrackColor: AppColors.boarderWhiteColor,
      ),
    );
  }
}
