import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:driver_mate/feature/mycars/view/vehicle_added_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Car brands list
const List<String> carBrands = [
  'Toyota',
  'Honda',
  'Hyundai',
  'Ford',
  'Chevrolet',
  'BMW',
  'Mercedes-Benz',
  'Audi',
  'Nissan',
  'Mazda',
  'Volkswagen',
  'Kia',
  'Lexus',
  'Tesla',
  'Other',
];

// Brand to models mapping
const Map<String, List<String>> brandModels = {
  'Toyota': [
    'Camry',
    'Corolla',
    'RAV4',
    'Highlander',
    'Prius',
    'Tacoma',
    'Tundra',
    'Land Cruiser',
    'Other',
  ],
  'Honda': [
    'Civic',
    'Accord',
    'CR-V',
    'Pilot',
    'Odyssey',
    'Fit',
    'HR-V',
    'Ridgeline',
    'Other',
  ],
  'Hyundai': [
    'Elantra',
    'Sonata',
    'Tucson',
    'Santa Fe',
    'Kona',
    'Palisade',
    'Venue',
    'Other',
  ],
  'Ford': [
    'F-150',
    'Mustang',
    'Explorer',
    'Escape',
    'Edge',
    'Expedition',
    'Ranger',
    'Other',
  ],
  'Chevrolet': [
    'Silverado',
    'Equinox',
    'Malibu',
    'Traverse',
    'Tahoe',
    'Camaro',
    'Colorado',
    'Other',
  ],
  'BMW': [
    '3 Series',
    '5 Series',
    '7 Series',
    'X3',
    'X5',
    'X7',
    'M3',
    'M5',
    'Other',
  ],
  'Mercedes-Benz': [
    'C-Class',
    'E-Class',
    'S-Class',
    'GLC',
    'GLE',
    'GLS',
    'A-Class',
    'Other',
  ],
  'Audi': ['A3', 'A4', 'A6', 'A8', 'Q3', 'Q5', 'Q7', 'Q8', 'Other'],
  'Nissan': [
    'Altima',
    'Maxima',
    'Sentra',
    'Rogue',
    'Pathfinder',
    'Murano',
    'Frontier',
    'Other',
  ],
  'Mazda': ['Mazda3', 'Mazda6', 'CX-3', 'CX-5', 'CX-9', 'MX-5 Miata', 'Other'],
  'Volkswagen': [
    'Jetta',
    'Passat',
    'Tiguan',
    'Atlas',
    'Golf',
    'Arteon',
    'ID.4',
    'Other',
  ],
  'Kia': [
    'Forte',
    'Optima',
    'Sorento',
    'Sportage',
    'Telluride',
    'Soul',
    'Stinger',
    'Other',
  ],
  'Lexus': ['ES', 'IS', 'LS', 'RX', 'NX', 'GX', 'LX', 'UX', 'Other'],
  'Tesla': ['Model 3', 'Model S', 'Model X', 'Model Y', 'Cybertruck', 'Other'],
  'Other': ['Other'],
};

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String? _selectedBrand;
  String? _selectedModel;
  int? _selectedYear;

  // Generate years from 1997 to 2027
  List<int> get _years {
    final currentYear = 2027;
    return List.generate(31, (index) => currentYear - index);
  }

  // Get available models for selected brand
  List<String> get _availableModels {
    if (_selectedBrand == null) return [];
    return brandModels[_selectedBrand] ?? ['Other'];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicalCubit, VehicalState>(
      listener: (context, state) {
        if (state is AddVehicalSuccessState) {
          AppNotifier.show(context, state.message, type: NotifierType.success);
          MyNavigation.navigateOff(
            VehicleAddedSuccessPage(vehicle: state.vehicle),
          );
        }

        if (state is ErrorVehicalState) {
          AppNotifier.show(context, state.error, type: NotifierType.error);
        }
      },
      builder: (context, state) {
        return Form(
          key: VehicalCubit.get(context).formKey,

          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                AppConstants.addVehicle,
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
                      padding: const EdgeInsets.all(12),
                      decoration:
                          BoxDecorationWidget.customBoxDecoration(
                            borderRadius: AppFontSize.f12,
                          ).copyWith(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.veryDarkBlue,
                                AppColors.cyanColor,
                              ],
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
                                    color: AppColors.white.withValues(
                                      alpha: 0.9,
                                    ),
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
                      value: _selectedBrand,
                      decoration: InputDecoration(
                        hintText: "Select Brand",
                        hintStyle: AppStyle.hintStyle,
                        filled: true,
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.cyanColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      items: carBrands.map((brand) {
                        return DropdownMenuItem<String>(
                          value: brand,
                          child: Text(brand, style: AppStyle.regularSmallText),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBrand = value;
                          _selectedModel =
                              null; // Reset model when brand changes
                          VehicalCubit.get(context).brandController.text =
                              value ?? '';
                          VehicalCubit.get(context).modelController.clear();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.youMust;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel(text: AppConstants.modelRequired),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedModel,
                      decoration: InputDecoration(
                        hintText: _selectedBrand == null
                            ? "Select Brand First"
                            : "Select Model",
                        hintStyle: AppStyle.hintStyle,
                        filled: true,
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.cyanColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      items: _availableModels.map((model) {
                        return DropdownMenuItem<String>(
                          value: model,
                          child: Text(model, style: AppStyle.regularSmallText),
                        );
                      }).toList(),
                      onChanged: _selectedBrand == null
                          ? null
                          : (value) {
                              setState(() {
                                _selectedModel = value;
                                VehicalCubit.get(context).modelController.text =
                                    value ?? '';
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.youMust;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel(text: AppConstants.yearRequired),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: _selectedYear,
                      decoration: InputDecoration(
                        hintText: "Select Year",
                        hintStyle: AppStyle.hintStyle,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          size: 20,
                          color: AppColors.iconGrey,
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.cyanColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      items: _years.map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(
                            year.toString(),
                            style: AppStyle.regularSmallText,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value;
                          VehicalCubit.get(context).yearController.text =
                              value?.toString() ?? '';
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return AppConstants.youMust;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel(text: AppConstants.plateNumberOptional),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: VehicalCubit.get(context).plateController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: AppConstants.plateNumberHint,
                        hintStyle: AppStyle.hintStyle,
                        filled: true,
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.cyanColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.youMust;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    _FieldLabel(text: AppConstants.currentMileageOptional),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: VehicalCubit.get(context).mileageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: AppConstants.mileageHint,
                        hintStyle: AppStyle.hintStyle,
                        filled: true,
                        fillColor: AppColors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.cyanColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f8),
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      validator: (value) {
                        // Mileage is optional, so only validate if value is provided
                        return null;
                      },
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
                      onPressed: () {
                        final cubit = VehicalCubit.get(context);

                        if (cubit.formKey.currentState!.validate()) {
                          final model = VechicleModel(
                            brand: cubit.brandController.text,
                            model: cubit.modelController.text,
                            year: int.tryParse(cubit.yearController.text),
                            plateNumber: cubit.plateController.text,
                            millAge: double.tryParse(
                              cubit.mileageController.text,
                            ),
                            date: DateTime.now(),
                          );

                          cubit.addVehicle(vehicle: model);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            VehicalCubit.get(
                              context,
                            ).formKey.currentState!.validate()
                            ? AppColors.cyanColor
                            : AppColors.boarderWhiteColor,
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
                          color:
                              VehicalCubit.get(
                                context,
                              ).formKey.currentState!.validate()
                              ? AppColors.white
                              : AppColors.iconGrey,
                          fontSize: AppFontSize.f13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
      style: AppStyle.labelStyle.copyWith(fontSize: AppFontSize.f12),
    );
  }
}
