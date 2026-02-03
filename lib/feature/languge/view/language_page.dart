import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/languge/view/widget/language_card.dart';
import 'package:driver_mate/feature/mycars/view/widget/container_widget.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.language, style: AppStyle.appBarTitle),
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
              title: AppConstants.english,
              subtitle: AppConstants.english,
              isSelected: _selectedLanguage == 'en',
              onTap: () {
                setState(() {
                  _selectedLanguage = 'en';
                });
              },
            ),
            SizedBox(height: SizeConfig.height(context) * 0.012),
            LanguageCard(
              title: AppConstants.arabic,
              subtitle: AppConstants.arabicNative,
              isSelected: _selectedLanguage == 'ar',
              onTap: () {
                setState(() {
                  _selectedLanguage = 'ar';
                });
              },
            ),
            SizedBox(height: SizeConfig.height(context) * 0.02),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            //   decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
            //     color: AppColors.lightBleu,
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.check_circle,
            //         color: AppColors.darkCyanColor,
            //         size: 18,
            //       ),
            //       const SizedBox(width: 8),
            //       Expanded(
            //         child: Text(
            //           AppConstants.languageRestartNote,
            //           style: AppStyle.regularSmallText.copyWith(
            //             color: AppColors.textGrey,
            //             fontSize: AppFontSize.f12,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ContainerWidget(firstText: AppConstants.restartLanguage),
            SizedBox(height: SizeConfig.height(context) * 0.025),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.height(context) * 0.018,
                ),
                backgroundColor: AppColors.boarderWhiteColor,
                disabledBackgroundColor: AppColors.boarderWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppFontSize.f12),
                ),
                elevation: 0,
              ),
              child: Text(
                AppConstants.saveChanges,
                style: AppStyle.boldSmallText.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f13,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.01),
            Center(
              child: Text(
                AppConstants.currentLanguageEnglish,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
