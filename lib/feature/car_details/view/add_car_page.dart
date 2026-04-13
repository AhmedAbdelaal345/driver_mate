// import 'package:driver_mate/core/helper/app_notifier.dart';
// import 'package:driver_mate/core/helper/my_navigation.dart';
// import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
// import 'package:driver_mate/core/utils/app_font_size.dart';
// import 'package:driver_mate/core/utils/app_style.dart';
// import 'package:driver_mate/core/utils/box_decoration.dart';
// import 'package:driver_mate/core/utils/size.dart';
// import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
// import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
// import 'package:driver_mate/feature/car_details/view/widget/form_field_widget.dart';
// import 'package:driver_mate/feature/car_details/view/widget/step_header.dart';
// import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
// import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
// import 'package:driver_mate/feature/mycars/view/vehicle_added_success_page.dart';
// import 'package:flutter/material.dart';

// class AddCarPage extends StatefulWidget {
//   const AddCarPage({super.key, this.carName});
//   final String? carName;
//   @override
//   State<AddCarPage> createState() => _AddCarPageState();
// }

// class _AddCarPageState extends State<AddCarPage> {
//   int _currentStep = 0;

//   // Step 1: Review Details Controllers
//   final TextEditingController _nicknameController = TextEditingController();
//   final TextEditingController _yearController = TextEditingController();
//   final TextEditingController _mileageController = TextEditingController();

//   // Step 2: Ownership Details Controllers
//   final TextEditingController _purchaseDateController = TextEditingController();
//   bool _serviceRemindersEnabled = true;

//   // Pre-filled car details (these would come from car details page)
//   late final String _carName = widget.carName ?? 'Toyota Camry 2024';
//   final List<String> _carSpecs = ['Automatic', 'Petrol', '2.5L Engine', 'FWD'];

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill year if coming from car details
//     _yearController.text = '2024';
//   }

//   @override
//   void dispose() {
//     _nicknameController.dispose();
//     _yearController.dispose();
//     _mileageController.dispose();
//     _purchaseDateController.dispose();
//     super.dispose();
//   }

//   void _nextStep() {
//     if (_currentStep < 1) {
//       setState(() {
//         _currentStep++;
//       });
//     }
//   }

//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() {
//         _currentStep--;
//       });
//     }
//   }

//   void _addCar() {
//     // TODO: Implement add car logic
//     final VechicleModel vehical = VechicleModel(
//       brand: _carName,
//       imagePath: ,
//       model: _nicknameController.text.isNotEmpty
//           ? _nicknameController.text
//           : "0",
//       year: _yearController.text.isNotEmpty
//           ? int.tryParse(_yearController.text) ?? 0
//           : 0,
//       millAge: _mileageController.text.isNotEmpty
//           ? double.tryParse(_mileageController.text) ?? 0
//           : 0,
//       date: _purchaseDateController.text.isNotEmpty
//           ? DateTime.tryParse(_purchaseDateController.text) ?? DateTime.now()
//           : DateTime.now(),
//     );
//     try {
//       VehicalCubit.get(context).addVehicle(vehicle: vehical);
//       MyNavigation.navigateTo(VehicleAddedSuccessPage(vehicle: vehical));
//     } on Exception catch (e) {
//       AppNotifier.show(context, e.toString(), type: NotifierType.error);
//     }
//   }

//   void _cancel() {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           AppConstants.addToMyCars,
//           style: AppStyle.appBarTitle,
//         ),
//         leading: const LeadingIcon(),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: SizeConfig.width(context) * 0.05,
//                   vertical: SizeConfig.height(context) * 0.015,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (_currentStep == 0) _buildStep1(),
//                     if (_currentStep == 1) _buildStep2(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           _buildBottomButtons(),
//         ],
//       ),
//     );
//   }

//   Widget _buildStep1() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         StepHeader(stepNumber: 1, title: AppConstants.reviewDetails),
//         const SizedBox(height: 24),

//         // Car Name
//         Text(
//           _carName,
//           style: AppStyle.boldSmallText.copyWith(
//             fontSize: AppFontSize.f18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),

//         // Car Specs Chips
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: _carSpecs.map((spec) {
//             return Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: AppColors.containerGrey.withValues(alpha: 0.5),
//                 borderRadius: BorderRadius.circular(999),
//               ),
//               child: Text(
//                 spec,
//                 style: AppStyle.containerSubtitle.copyWith(
//                   fontSize: AppFontSize.f11,
//                   color: AppColors.textGrey,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 24),

//         // Nickname Field
//         FormFieldWidget(
//           label: AppConstants.nickname,
//           isOptional: true,
//           child: TextField(
//             controller: _nicknameController,
//             decoration: InputDecoration(
//               hintText: AppConstants.nicknameHint,
//               hintStyle: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.cyanColor),
//               ),
//               contentPadding: const EdgeInsets.all(16),
//             ),
//             style: AppStyle.containerSubtitle.copyWith(
//               fontSize: AppFontSize.f12,
//               color: AppColors.textGrey,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),

//         // Year Field
//         FormFieldWidget(
//           label: AppConstants.year,
//           child: TextField(
//             controller: _yearController,
//             readOnly: true,
//             decoration: InputDecoration(
//               prefixIcon: Icon(
//                 Icons.calendar_today_outlined,
//                 color: AppColors.iconGrey,
//                 size: 20,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.cyanColor),
//               ),
//               contentPadding: const EdgeInsets.all(16),
//             ),
//             style: AppStyle.containerSubtitle.copyWith(
//               fontSize: AppFontSize.f12,
//               color: AppColors.textGrey,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),

//         // Current Mileage Field
//         FormFieldWidget(
//           label: AppConstants.currentMileage,
//           isOptional: true,
//           child: TextField(
//             controller: _mileageController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: AppConstants.currentMileageHint,
//               hintStyle: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.cyanColor),
//               ),
//               contentPadding: const EdgeInsets.all(16),
//             ),
//             style: AppStyle.containerSubtitle.copyWith(
//               fontSize: AppFontSize.f12,
//               color: AppColors.textGrey,
//             ),
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildStep2() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         StepHeader(stepNumber: 2, title: AppConstants.ownershipDetails),
//         const SizedBox(height: 24),

//         // Purchase Date Field
//         FormFieldWidget(
//           label: AppConstants.purchaseDate,
//           isOptional: true,
//           child: TextField(
//             controller: _purchaseDateController,
//             readOnly: true,
//             decoration: InputDecoration(
//               hintText: AppConstants.purchaseDateHint,
//               hintStyle: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f12),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.containerGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(AppFontSize.f8),
//                 borderSide: BorderSide(color: AppColors.cyanColor),
//               ),
//               contentPadding: const EdgeInsets.all(16),
//             ),
//             style: AppStyle.containerSubtitle.copyWith(
//               fontSize: AppFontSize.f12,
//               color: AppColors.textGrey,
//             ),
//             onTap: () async {
//               final date = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime.now(),
//               );
//               if (date != null) {
//                 setState(() {
//                   _purchaseDateController.text =
//                       '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
//                 });
//               }
//             },
//           ),
//         ),
//         const SizedBox(height: 24),

//         // Service Reminders Toggle
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecorationWidget.customBoxDecoration(
//             borderRadius: AppFontSize.f12,
//           ).copyWith(color: AppColors.white),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppConstants.serviceReminders,
//                       style: AppStyle.boldSmallText.copyWith(
//                         fontSize: AppFontSize.f13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       AppConstants.serviceRemindersDescription,
//                       style: AppStyle.containerSubtitle.copyWith(
//                         fontSize: AppFontSize.f11,
//                         color: AppColors.iconGrey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Switch(
//                 value: _serviceRemindersEnabled,
//                 onChanged: (value) {
//                   setState(() {
//                     _serviceRemindersEnabled = value;
//                   });
//                 },
//                 activeThumbColor: AppColors.white,
//                 activeTrackColor: AppColors.cyanColor,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),

//         // Info Banner
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.cyanColor.withValues(alpha: 0.1),
//             borderRadius: BorderRadius.circular(AppFontSize.f12),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: AppColors.cyanColor,
//                   borderRadius: BorderRadius.circular(999),
//                 ),
//                 child: const Icon(
//                   Icons.notifications_outlined,
//                   color: AppColors.white,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppConstants.stayOnTopMaintenance,
//                       style: AppStyle.boldSmallText.copyWith(
//                         fontSize: AppFontSize.f13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       AppConstants.stayOnTopMaintenanceDescription,
//                       style: AppStyle.containerSubtitle.copyWith(
//                         fontSize: AppFontSize.f11,
//                         color: AppColors.textGrey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 24),
//       ],
//     );
//   }

//   Widget _buildBottomButtons() {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: SizeConfig.width(context) * 0.05,
//         vertical: SizeConfig.height(context) * 0.015,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             PrimaryElevatedButtonWidget(
//               onPressed: _currentStep == 1 ? _addCar : _nextStep,
//               buttonText: AppConstants.addToMyCars,
//               icon: Icons.check,
//             ),
//             const SizedBox(height: 12),
//             SizedBox(
//               width: double.infinity,
//               child: TextButton(
//                 onPressed: _currentStep == 0 ? _cancel : _previousStep,
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(AppFontSize.f12),
//                   ),
//                 ),
//                 child: Text(
//                   AppConstants.cancel,
//                   style: AppStyle.containerSubtitle.copyWith(
//                     fontSize: AppFontSize.f14,
//                     color: AppColors.textGrey,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
