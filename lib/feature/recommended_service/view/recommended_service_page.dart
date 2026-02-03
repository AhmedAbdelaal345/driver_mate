import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class RecommendedServicePage extends StatelessWidget {
  const RecommendedServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppConstants.recommendedServiceTitle,
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: AppColors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_gas_station,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppConstants.oilChangeDue,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.perpule.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        AppConstants.aiBasedRecommendation,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color: AppColors.perpule,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppConstants.recommendedServiceNote,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.iconGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppConstants.confidenceLevel,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: AppColors.iconGrey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              minHeight: 6,
                              value: 0.85,
                              backgroundColor: AppColors.containerGrey,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppConstants.high,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: AppColors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.quickActions,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              _ActionCard(
                icon: Icons.location_on_outlined,
                iconColor: AppColors.cyanColor,
                title: AppConstants.findNearestCenter,
                subtitle: AppConstants.findNearestCenterSub,
              ),
              const SizedBox(height: 10),
              _ActionCard(
                icon: Icons.calendar_month_outlined,
                iconColor: AppColors.cyanColor,
                title: AppConstants.bookNow,
                subtitle: AppConstants.bookNowSub,
                isPrimary: true,
              ),
              const SizedBox(height: 10),
              _ActionCard(
                icon: Icons.notifications_none,
                iconColor: AppColors.orange,
                title: AppConstants.setReminder,
                subtitle: AppConstants.setReminderSub,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.isPrimary = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(
        color: isPrimary ? AppColors.cyanColor : AppColors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isPrimary
                  ? AppColors.white.withValues(alpha: 0.2)
                  : iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPrimary ? AppColors.white : iconColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f12,
                    color: isPrimary ? AppColors.white : AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f10,
                    color:
                        isPrimary ? AppColors.white : AppColors.iconGrey,
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
