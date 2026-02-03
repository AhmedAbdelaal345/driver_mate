import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _plateController = TextEditingController();
  final TextEditingController _mileageController = TextEditingController();

  String? _brand;
  String? _year;

  final List<String> _brands = const [
    "Toyota",
    "Honda",
    "BMW",
    "Mercedes",
  ];

  final List<String> _years = const [
    "2025",
    "2024",
    "2023",
    "2022",
  ];

  @override
  void dispose() {
    _modelController.dispose();
    _plateController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.addVehicle, style: AppStyle.appBarTitle),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.registerVehicle,
                            style: AppStyle.boldSmallText.copyWith(
                              color: AppColors.white,
                              fontSize: AppFontSize.f13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AppConstants.registerVehicleHint,
                            style: AppStyle.containerSubtitle.copyWith(
                              color: AppColors.white.withValues(alpha: 0.9),
                              fontSize: AppFontSize.f11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              _FieldLabel(text: AppConstants.brandRequired),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _brand,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: _dropdownDecoration(),
                items: _brands
                    .map(
                      (brand) => DropdownMenuItem(
                        value: brand,
                        child: Text(brand),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _brand = value;
                  });
                },
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: AppConstants.modelRequired),
              const SizedBox(height: 8),
              TextFormFieldWidget(
                hintText: AppConstants.modelHint,
                controller: _modelController,
                validator: (value) => null,
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: AppConstants.yearRequired),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _year,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: _dropdownDecoration(),
                items: _years
                    .map(
                      (year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _year = value;
                  });
                },
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: AppConstants.plateNumberOptional),
              const SizedBox(height: 8),
              TextFormFieldWidget(
                hintText: AppConstants.plateNumberHint,
                controller: _plateController,
                validator: (value) => null,
              ),
              const SizedBox(height: 14),
              _FieldLabel(text: AppConstants.currentMileageOptional),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mileageController,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.cyanColor,
                decoration: InputDecoration(
                  hintText: AppConstants.mileageHint,
                  hintStyle: AppStyle.hintStyle,
                  suffixText: AppConstants.km,
                  suffixStyle: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.cyanColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f8),
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.lightBleu),
                child: Text(
                  AppConstants.addVehicleNote,
                  style: AppStyle.regularSmallText.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boarderWhiteColor,
                  disabledBackgroundColor: AppColors.boarderWhiteColor,
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.height(context) * 0.018,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                  ),
                ),
                child: Text(
                  AppConstants.addVehicle,
                  style: AppStyle.boldSmallText.copyWith(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppFontSize.f8),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppFontSize.f8),
        borderSide: BorderSide(color: AppColors.cyanColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppFontSize.f8),
        borderSide: BorderSide(color: AppColors.grey),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.labelStyle.copyWith(
        fontSize: AppFontSize.f12,
      ),
    );
  }
}
