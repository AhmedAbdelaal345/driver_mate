import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  int _selectedChip = 0;
  final List<String> _chips = const [
    AppConstants.all,
    AppConstants.account,
    AppConstants.maintenance,
  ];

  final List<String> _questions = const [
    AppConstants.faqAddVehicle,
    AppConstants.faqAiDiagnosis,
    AppConstants.faqBookService,
    AppConstants.faqCancelBooking,
    AppConstants.faqEmergency,
    AppConstants.faqChangePassword,
    AppConstants.faqVehicleSecure,
    AppConstants.faqAiAccuracy,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.helpCenter, style: AppStyle.appBarTitle),
        leading: const LeadingIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.cyanColor),
          ),
        ],
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
              TextField(
                cursorColor: AppColors.cyanColor,
                decoration: InputDecoration(
                  hintText: AppConstants.searchHelp,
                  hintStyle: AppStyle.hintStyle,
                  prefixIcon: const Icon(Icons.search, color: AppColors.iconGrey),
                  filled: true,
                  fillColor: AppColors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.boarderWhiteColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.cyanColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                    borderSide: BorderSide(color: AppColors.boarderWhiteColor),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.015),
              Wrap(
                spacing: 8,
                children: List.generate(_chips.length, (index) {
                  final isSelected = _selectedChip == index;
                  return ChoiceChip(
                    label: Text(
                      _chips[index],
                      style: AppStyle.containerSubtitle.copyWith(
                        color: isSelected ? AppColors.white : AppColors.textGrey,
                        fontSize: AppFontSize.f11,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedChip = index;
                      });
                    },
                    selectedColor: AppColors.cyanColor,
                    backgroundColor: AppColors.containerGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.faqTitle,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  children: List.generate(_questions.length, (index) {
                    final isLast = index == _questions.length - 1;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            _questions[index],
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f12,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.iconGrey,
                          ),
                          onTap: () {},
                        ),
                        if (!isLast) Divider(color: AppColors.containerGrey),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
