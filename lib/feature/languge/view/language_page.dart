import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/languge/manager/languge_cubit.dart';
import 'package:driver_mate/feature/languge/view/widget/language_card.dart';
import 'package:driver_mate/feature/mycars/view/widget/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    // state IS the Locale directly
    _selectedLanguage = context.read<LanguageCubit>().state.languageCode;
  }

  String _currentLanguageLabel(BuildContext context, String savedCode) {
    final s = AppStrings.of(context);
    final langName = savedCode == 'ar' ? s.arabic : s.english;
    return '${s.currentLanguageLabel}: $langName';
  }

  @override
  Widget build(BuildContext context) {
    print(Localizations.localeOf(context));
    print(context.read<LanguageCubit>().state);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).language,
          style: AppStyle.appBarTitle,
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
            LanguageCard(
              title: AppStrings.of(context).english,
              subtitle: 'English',
              isSelected: _selectedLanguage == 'en',
              onTap: () => setState(() => _selectedLanguage = 'en'),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.012),
            LanguageCard(
              title: AppStrings.of(context).arabic,
              subtitle: 'العربية',
              isSelected: _selectedLanguage == 'ar',
              onTap: () => setState(() => _selectedLanguage = 'ar'),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.02),
            ContainerWidget(firstText: AppStrings.of(context).restartLanguage),
            SizedBox(height: SizeConfig.height(context) * 0.025),
            ElevatedButton(
              onPressed: () async {
                print("Selected = $_selectedLanguage");

                await context.read<LanguageCubit>().changeLanguage(
                  _selectedLanguage,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height(context) * 0.018,
                ),
                backgroundColor: AppColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppFontSize.f12),
                ),
                elevation: 0,
              ),
              child: Text(
                AppStrings.of(context).saveChanges,
                style: AppStyle.boldSmallText.copyWith(
                  color: AppColors.white,
                  fontSize: AppFontSize.f13,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.01),

            // ── Dynamic "Current language" label ──────────────────────────
            // state IS Locale, so BlocBuilder<LanguageCubit, Locale>
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return Center(
                  child: Text(
                    _currentLanguageLabel(context, locale.languageCode),
                    style: AppStyle.containerSubtitle.copyWith(
                      color: AppColors.iconGrey,
                      fontSize: AppFontSize.f11,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
