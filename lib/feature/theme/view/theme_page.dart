import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/theme/view/widget/theme_card.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  ThemeModeOption _selected = ThemeModeOption.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.theme, style: AppStyle.appBarTitle),
        leading: const LeadingIcon(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ThemeCard(
              title: AppConstants.lightMode,
              icon: Icons.wb_sunny_outlined,
              isSelected: _selected == ThemeModeOption.light,
              previewBackground: AppColors.boarderWhiteColor,
              previewCard: AppColors.white,
              previewLine: AppColors.black,
              onTap: () {
                setState(() {
                  _selected = ThemeModeOption.light;
                });
              },
            ),
            SizedBox(height: SizeConfig.height(context) * 0.02),
            ThemeCard(
              title: AppConstants.darkMode,
              icon: Icons.nightlight_round,
              isSelected: _selected == ThemeModeOption.dark,
              previewBackground: AppColors.veryDarkBlue,
              previewCard: AppColors.darkBlue,
              previewLine: AppColors.white,
              onTap: () {
                setState(() {
                  _selected = ThemeModeOption.dark;
                });
              },
            ),
            SizedBox(height: SizeConfig.height(context) * 0.02),
            ThemeCard(
              title: AppConstants.systemDefault,
              icon: Icons.phone_android,
              isSelected: _selected == ThemeModeOption.system,
              previewBackground: AppColors.containerGrey,
              previewCard: AppColors.white,
              previewLine: AppColors.black,
              onTap: () {
                setState(() {
                  _selected = ThemeModeOption.system;
                });
              },
            ),
            SizedBox(height: SizeConfig.height(context) * 0.03),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecorationWidget.customBoxDecoration(
                borderRadius: AppFontSize.f12,
              ).copyWith(
                color: AppColors.containerGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.autoSaveEnabled,
                    style: AppStyle.boldSmallText.copyWith(
                      color: AppColors.cyanColor,
                      fontSize: AppFontSize.f12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppConstants.autoSaveThemeNote,
                    style: AppStyle.regularSmallText.copyWith(
                      color: AppColors.iconGrey,
                      fontSize: AppFontSize.f11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
