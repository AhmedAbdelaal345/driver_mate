import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
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
  

 
  @override
  Widget build(BuildContext context) {
    final List<String> _chips =  [
    AppStrings.of(context).all,
    AppStrings.of(context).account,
    AppStrings.of(context).maintenance,
  ];

   final List<String> _questions =  [
    AppStrings.of(context).faqAddVehicle,
    AppStrings.of(context).faqAiDiagnosis,
    AppStrings.of(context).faqBookService,
    AppStrings.of(context).faqCancelBooking,
    AppStrings.of(context).faqEmergency,
    AppStrings.of(context).faqChangePassword,
    AppStrings.of(context).faqVehicleSecure,
    AppStrings.of(context).faqAiAccuracy,
  ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title:  Text(AppStrings.of(context).helpCenter, style: AppStyle.appBarTitle.copyWith(color: Theme.of(context).appBarTheme.titleTextStyle?.color)),
        leading: const LeadingIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon:  Icon(Icons.chat_bubble_outline, color: Theme.of(context).appBarTheme.iconTheme?.color),
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
                  prefixIcon:  Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
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
                        color: isSelected ?Theme.of(context).appBarTheme.titleTextStyle?.color : Theme.of(context).textTheme.bodyMedium?.color,
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
                AppStrings.of(context).faqTitle,
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: Theme.of(context).cardColor),
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
                          trailing:  Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onTap: () {},
                        ),
                        if (!isLast) Divider(color: Theme.of(context).dividerColor),
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
