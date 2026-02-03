import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.about, style: AppStyle.appBarTitle),
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
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.darkCyanColor,
                        borderRadius: BorderRadius.circular(AppFontSize.f16),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppImagePath.aboutIconPath,
                          width: 30,
                          height: 30,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppConstants.driverMate,
                      style: AppStyle.titleForContainer,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppConstants.aboutSubtitle,
                      textAlign: TextAlign.center,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.iconGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.cyanColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppConstants.versionNumber,
                            style: AppStyle.containerSubtitle.copyWith(
                              fontSize: AppFontSize.f10,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppConstants.legal),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: const [
                    _InfoTile(
                      title: AppConstants.termsOfService,
                      subtitle: AppConstants.termsOfServiceSub,
                      icon: Icons.description_outlined,
                    ),
                    Divider(color: AppColors.containerGrey),
                    _InfoTile(
                      title: AppConstants.privacyPolicy,
                      subtitle: AppConstants.privacyPolicySub,
                      icon: Icons.shield_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppConstants.contact),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: const _InfoTile(
                  title: AppConstants.contactUs,
                  subtitle: AppConstants.supportEmail,
                  icon: Icons.mail_outline,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.03),
              Column(
                children: [
                  Text(
                    AppConstants.madeWithLove,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: AppColors.iconGrey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConstants.copyright,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: AppColors.iconGrey,
                      fontWeight: FontWeight.normal,
                    ),
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

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
