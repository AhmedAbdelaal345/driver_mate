import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/profile/view/widget/details_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).about,
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardTheme.color),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
                      AppStrings.of(context).driverMate,
                      style: AppStyle.titleForContainer.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        fontSize: AppFontSize.f18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppStrings.of(context).aboutSubtitle,
                      textAlign: TextAlign.center,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f11,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
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
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.of(context).versionNumber,
                            style: AppStyle.containerSubtitle.copyWith(
                              fontSize: AppFontSize.f10,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppStrings.of(context).legal),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardTheme.color),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      title: AppStrings.of(context).termsOfService,
                      subTitle: AppStrings.of(context).termsOfServiceSub,
                      icon: Icons.description_outlined,
                      isSvg: false,
                    ),
                    Divider(color: Theme.of(context).dividerColor),
                    DetailsContainerWidget(
                      title: AppStrings.of(context).privacyPolicy,
                      subTitle: AppStrings.of(context).privacyPolicySub,
                      icon: Icons.shield_outlined,
                      isSvg: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.025),
              _SectionLabel(text: AppStrings.of(context).contact),
              SizedBox(height: SizeConfig.height(context) * 0.012),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardTheme.color),
                child: DetailsContainerWidget(
                  title: AppStrings.of(context).contactUs,
                  isSvg: false,
                  subTitle: "ahmeed.abdeelaal@gmail.com",
                  icon: Icons.mail_outline,
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.03),
              Column(
                children: [
                  Text(
                    AppStrings.of(context).madeWithLove,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.of(context).copyright,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontSize: AppFontSize.f11,
      ),
    );
  }
}
