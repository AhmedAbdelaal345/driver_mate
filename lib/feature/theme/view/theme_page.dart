import 'package:driver_mate/core/theme/theme.dart';
import 'package:driver_mate/core/theme/theme_cubit.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/theme/view/widget/theme_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeModeOption { light, dark, system }

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  late ThemeModeOption _selected;

  @override
  void initState() {
    super.initState();
    _selected = context.read<ThemeCubit>().isDark
        ? ThemeModeOption.dark
        : ThemeModeOption.light;
  }

  void _selectTheme(ThemeModeOption option) {
    setState(() => _selected = option);

    switch (option) {
      case ThemeModeOption.light:
        context.read<ThemeCubit>().setTheme(lightMode);
        break;
      case ThemeModeOption.dark:
        context.read<ThemeCubit>().setTheme(darkMode);
        break;
      case ThemeModeOption.system:
        // System follows device brightness
        final brightness = MediaQuery.of(context).platformBrightness;
        context.read<ThemeCubit>().setTheme(
          brightness == Brightness.dark ? darkMode : lightMode,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.of(context).theme,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
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
              title: AppStrings.of(context).lightMode,
              icon: Icons.wb_sunny_outlined,
              isSelected: _selected == ThemeModeOption.light,
              previewBackground: AppColors.boarderWhiteColor,
              previewCard: AppColors.white,
              previewLine: AppColors.black,
              onTap: () => _selectTheme(ThemeModeOption.light),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            ThemeCard(
              title: AppStrings.of(context).darkMode,
              icon: Icons.nightlight_round,
              isSelected: _selected == ThemeModeOption.dark,
              previewBackground: const Color(0xFF0D1B2A),
              previewCard: const Color(0xFF1A2D42),
              previewLine: AppColors.white,
              onTap: () => _selectTheme(ThemeModeOption.dark),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            ThemeCard(
              title: AppStrings.of(context).systemDefault,
              icon: Icons.phone_android,
              isSelected: _selected == ThemeModeOption.system,
              previewBackground: AppColors.containerGrey,
              previewCard: AppColors.white,
              previewLine: AppColors.black,
              onTap: () => _selectTheme(ThemeModeOption.system),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.03),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecorationWidget.customBoxDecoration(
                context,
                borderRadius: AppFontSize.f12,
              ).copyWith(color: Theme.of(context).colorScheme.surface),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.of(context).autoSaveEnabled,
                    style: AppStyle.boldSmallText.copyWith(
                      color: AppColors.cyanColor,
                      fontSize: AppFontSize.f12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.of(context).autoSaveThemeNote,
                    style: AppStyle.regularSmallText.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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
