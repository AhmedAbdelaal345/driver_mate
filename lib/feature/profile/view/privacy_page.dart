import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).privacy,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
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
              _SectionLabel(text: AppStrings.of(context).appPermissions),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardColor),
                child: Column(
                  children: [
                    _PermissionTile(
                      title: AppStrings.of(context).location,
                      subtitle: AppStrings.of(context).allowed,
                      icon: Icons.location_on_outlined,
                      statusColor: AppColors.cyanColor,
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    _PermissionTile(
                      title: AppStrings.of(context).microphone,
                      subtitle: AppStrings.of(context).notAllowed,
                      icon: Icons.mic_none,
                      statusColor: AppColors.iconGrey,
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    _PermissionTile(
                      title: AppStrings.of(context).notifications,
                      subtitle: AppStrings.of(context).allowed,
                      icon: Icons.notifications_none,
                      statusColor: AppColors.cyanColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.of(context).permissionsInfoTitle,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f12,
                        color: Theme.of(  context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.of(context).permissionsInfoBody,
                      style: AppStyle.regularSmallText.copyWith(
                        fontSize: AppFontSize.f11,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppStrings.of(context).yourData),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardColor),
                child: Column(
                  children: [
                    _SimpleActionTile(
                      title: AppStrings.of(context).clearSearchHistory,
                      subtitle: AppStrings.of(context).clearSearchHistorySub,
                      icon: Icons.delete_outline,
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    _SimpleActionTile(
                      title: AppStrings.of(context).requestDataExport,
                      subtitle: AppStrings.of(context).requestDataExportSub,
                      icon: Icons.download_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppStrings.of(context).dangerZone),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ),
                child: _SimpleActionTile(
                  title: AppStrings.of(context).deleteAccount,
                  subtitle: AppStrings.of(context).deleteAccountSub,
                  icon: Icons.warning_amber_rounded,
                  isDanger: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.containerSubtitle.copyWith(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: AppFontSize.f11,
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.statusColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.cyanColor.withValues(alpha: 0.12),
        child: Icon(icon, color: AppColors.cyanColor, size: 18),
      ),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f11,
          color: statusColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {},
    );
  }
}

class _SimpleActionTile extends StatelessWidget {
  const _SimpleActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDanger = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final textColor = isDanger ? AppColors.red : AppColors.black;
    final iconColor = isDanger ? AppColors.red : AppColors.cyanColor;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.cyanColor.withValues(alpha: 0.12),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(
          fontSize: AppFontSize.f13,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f11,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing:  Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {},
    );
  }
}
