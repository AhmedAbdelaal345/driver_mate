import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/notification/data/repo/notification_setting_repo.dart';
import 'package:driver_mate/feature/notification/manager/cubit/notification_setting_cubit.dart';
import 'package:driver_mate/feature/notification/manager/state/notification_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSettingPage extends StatefulWidget {
  const NotificationSettingPage({super.key});

  @override
  State<NotificationSettingPage> createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  final bool _maintenance = true;
  final bool _offers = true;
  final bool _aiAlerts = true;
  final bool _emergency = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationSettingsCubit(NotificationSettingsRepo())..loadSettings(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title:  Text(
            AppStrings.of(context).notifications,
            style: Theme.of(context).appBarTheme.titleTextStyle,
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
                Text(
                  AppStrings.of(context).notificationPreferences,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: AppFontSize.f11,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.012),
                Container(
                  decoration: BoxDecorationWidget.customBoxDecoration(context,
                    borderRadius: AppFontSize.f12,
                  ),
                  child: Column(
                    children: [
                      BlocBuilder<
                        NotificationSettingsCubit,
                        NotificationSettingsState
                      >(
                        builder: (context, state) {
                          if (state is NotificationSettingsLoaded) {
                            return _NotificationSwitchTile(
                              title: AppStrings.of(context).maintenanceReminders,
                              subtitle: AppStrings.of(context).maintenanceRemindersSub,
                              value: state.maintenance,
                              onChanged: (value) {
                                context
                                    .read<NotificationSettingsCubit>()
                                    .toggleMaintenance(value);
                              },
                            );
                          }
                          return _NotificationSwitchTile(
                            title: AppStrings.of(context).maintenanceReminders,
                            subtitle: AppStrings.of(context).maintenanceRemindersSub,
                            value: _maintenance,
                            onChanged: (value) {
                              value = true;
                            },
                          );
                        },
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      BlocBuilder<
                        NotificationSettingsCubit,
                        NotificationSettingsState
                      >(
                        builder: (context, state) {
                          if (state is NotificationSettingsLoaded) {
                            return _NotificationSwitchTile(
                              title: AppStrings.of(context).offersPromotions,
                              subtitle: AppStrings.of(context).offersPromotionsSub,
                              value: state.offers,
                              onChanged: (value) {
                                context
                                    .read<NotificationSettingsCubit>()
                                    .toggleOffers(value);
                              },
                            );
                          }
                          return _NotificationSwitchTile(
                            title: AppStrings.of(context).offersPromotions,
                            subtitle: AppStrings.of(context).offersPromotionsSub,
                            value: _offers,
                            onChanged: (value) {},
                          );
                        },
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      BlocBuilder<
                        NotificationSettingsCubit,
                        NotificationSettingsState
                      >(
                        builder: (context, state) {
                          if (state is NotificationSettingsLoaded) {
                            return _NotificationSwitchTile(
                              title: AppStrings.of(context).aiAlerts,
                              subtitle: AppStrings.of(context).aiAlertsSub,
                              value: state.ai,
                              onChanged: (value) {
                                context
                                    .read<NotificationSettingsCubit>()
                                    .toggleAI(value);
                              },
                            );
                          }
                          return _NotificationSwitchTile(
                            title: AppStrings.of(context).aiAlerts,
                            subtitle: AppStrings.of(context).aiAlertsSub,
                            value: _aiAlerts,
                            onChanged: (value) {},
                          );
                        },
                      ),
                      Divider(color: Theme.of(context).dividerColor),
                      BlocBuilder<
                        NotificationSettingsCubit,
                        NotificationSettingsState
                      >(
                        builder: (context, state) {
                          if (state is NotificationSettingsLoaded) {
                            return _NotificationSwitchTile(
                              title: AppStrings.of(context).emergencyUpdates,
                              subtitle: AppStrings.of(context).emergencyUpdatesSub,
                              value: state.emergency,
                              onChanged: (value) {
                                context
                                    .read<NotificationSettingsCubit>()
                                    .toggleEmergency(value);
                              },
                            );
                          }
                          return _NotificationSwitchTile(
                            title: AppStrings.of(context).emergencyUpdates,
                            subtitle: AppStrings.of(context).emergencyUpdatesSub,
                            value: _emergency,
                            onChanged: (value) {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.025),
                Text(
                  AppStrings.of(context).schedule,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: AppFontSize.f11,
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.012),
                Container(
                  decoration: BoxDecorationWidget.customBoxDecoration(context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).cardColor),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary.withValues(
                        alpha: 0.12,
                      ),
                      child:  Icon(
                        Icons.access_time,
                        color:Theme.of(context).colorScheme.secondary,
                        size: 18,
                      ),
                    ),
                    title: Text(
                      AppStrings.of(context).notificationSchedule,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    subtitle: Text(
                      AppStrings.of(context).setQuietHours,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    trailing:  Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.025),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecorationWidget.customBoxDecoration(context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).cardColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Icon(
                        Icons.notifications_none,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.of(context).notificationSettings,
                              style: AppStyle.boldSmallText.copyWith(
                                fontSize: AppFontSize.f12,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.of(context).notificationSettingsSub,
                              style: AppStyle.regularSmallText.copyWith(
                                fontSize: AppFontSize.f11,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
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
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.cyanColor,
        activeTrackColor: AppColors.smoothcyanColor,
        inactiveThumbColor: AppColors.iconGrey,
        inactiveTrackColor: AppColors.boarderWhiteColor,
      ),
    );
  }
}
