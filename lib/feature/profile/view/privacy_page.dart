import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.privacy, style: AppStyle.appBarTitle),
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
              _SectionLabel(text: AppConstants.appPermissions),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: const [
                    _PermissionTile(
                      title: AppConstants.location,
                      subtitle: AppConstants.allowed,
                      icon: Icons.location_on_outlined,
                      statusColor: AppColors.cyanColor,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _PermissionTile(
                      title: AppConstants.microphone,
                      subtitle: AppConstants.notAllowed,
                      icon: Icons.mic_none,
                      statusColor: AppColors.iconGrey,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _PermissionTile(
                      title: AppConstants.notifications,
                      subtitle: AppConstants.allowed,
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
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.lightBleu),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.permissionsInfoTitle,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f12,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppConstants.permissionsInfoBody,
                      style: AppStyle.regularSmallText.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.iconGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppConstants.yourData),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: const [
                    _SimpleActionTile(
                      title: AppConstants.clearSearchHistory,
                      subtitle: AppConstants.clearSearchHistorySub,
                      icon: Icons.delete_outline,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _SimpleActionTile(
                      title: AppConstants.requestDataExport,
                      subtitle: AppConstants.requestDataExportSub,
                      icon: Icons.download_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppConstants.dangerZone),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: const _SimpleActionTile(
                  title: AppConstants.deleteAccount,
                  subtitle: AppConstants.deleteAccountSub,
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
        color: AppColors.iconGrey,
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
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.iconGrey,
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
          color: AppColors.iconGrey,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: AppColors.iconGrey,
      ),
      onTap: () {},
    );
  }
}
