import 'package:driver_mate/core/helper/my_navigation.dart';
// import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
// import 'package:driver_mate/core/utils/app_font_size.dart';
// import 'package:driver_mate/core/utils/app_style.dart';
// import 'package:driver_mate/core/utils/box_decoration.dart';
// import 'package:driver_mate/core/utils/size.dart';
// import 'package:driver_mate/feature/booking/data/model/maintenance_center_model.dart';
// import 'package:driver_mate/feature/booking/data/repo/maintenance_repo.dart';
// import 'package:driver_mate/feature/home/view/wrapper_page.dart';
// import 'package:flutter/material.dart';

// class MaintenanceBookingPage extends StatefulWidget {
//   const MaintenanceBookingPage({super.key});

//   @override
//   State<MaintenanceBookingPage> createState() => _MaintenanceBookingPageState();
// }

// class _MaintenanceBookingPageState extends State<MaintenanceBookingPage> {
//   List<MaintenanceCenter> _centers = [];
//   MaintenanceCenter? _selectedCenter;
//   bool _isLoading = true;

//   String _selectedDate = '07/27/2026';
//   String? _selectedTime;

//   final List<String> _timeSlots = [
//     '9:00 AM',
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 PM',
//     '2:00 PM',
//     '3:00 PM',
//     '4:00 PM',
//     '5:00 PM',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _loadCenters();
//   }

//   Future<void> _loadCenters() async {
//     final centers = await MaintenanceRepo().getSortedCenters();
//     setState(() {
//       _centers = centers;
//       if (_centers.isNotEmpty) {
//         _selectedCenter = _centers.first;
//       }
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           AppConstants.maintenanceBooking,
//           style: AppStyle.appBarTitle,
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: EdgeInsets.all(SizeConfig.width(context) * 0.04),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppConstants.selectServiceCenter,
//                     style: AppStyle.boldSmallText.copyWith(
//                       fontSize: AppFontSize.f15,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   // Service Center List
//                   _buildCentersList(),
//                   const SizedBox(height: 24),

//                   if (_selectedCenter != null) ...[
//                     // Service Details Section
//                     _buildServiceDetails(),
//                     const SizedBox(height: 24),

//                     // Select Date
//                     _buildDateSelector(context),
//                     const SizedBox(height: 24),

//                     // Select Time
//                     _buildTimeSelector(),
//                     const SizedBox(height: 32),

//                     // Confirm Booking Button
//                     _buildConfirmButton(context),
//                     const SizedBox(height: 16),
//                   ],

//                   // Back Link
//                   Center(
//                     child: TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text(
//                         'Back',
//                         style: AppStyle.regularSmallText.copyWith(
//                           color: AppColors.cyanColor,
//                           fontSize: AppFontSize.f13,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildCentersList() {
//     return SizedBox(
//       height: 180, // Fixed height for the cards
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: _centers.length,
//         separatorBuilder: (context, index) => const SizedBox(width: 12),
//         itemBuilder: (context, index) {
//           final center = _centers[index];
//           final isSelected = _selectedCenter == center;
//           return _buildServiceCenterCard(center, isSelected);
//         },
//       ),
//     );
//   }

//   Widget _buildServiceCenterCard(MaintenanceCenter center, bool isSelected) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedCenter = center;
//         });
//       },
//       child: Container(
//         width:
//             SizeConfig.width(context) * 0.8, // Partial width to show scrolling
//         padding: const EdgeInsets.all(16),
//         decoration:
//             BoxDecorationWidget.customBoxDecoration(
//               borderRadius: AppFontSize.f12,
//             ).copyWith(
//               color: AppColors.white,
//               border: isSelected
//                   ? Border.all(color: AppColors.cyanColor, width: 2)
//                   : null,
//             ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Icon
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: AppColors.cyanColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.build, color: AppColors.white, size: 28),
//             ),
//             const SizedBox(width: 12),

//             // Service Center Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           center.name,
//                           style: AppStyle.boldSmallText.copyWith(
//                             fontSize: AppFontSize.f14,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.amber.shade100,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.star,
//                               size: 14,
//                               color: Colors.amber,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               center.rating.toString(),
//                               style: AppStyle.boldSmallText.copyWith(
//                                 fontSize: AppFontSize.f11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 14,
//                         color: AppColors.cyanColor,
//                       ),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           '${center.distance?.toStringAsFixed(1) ?? "?"} km • ${center.address}',
//                           style: AppStyle.regularSmallText.copyWith(
//                             fontSize: AppFontSize.f11,
//                             color: AppColors.iconGrey,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   if (center.isRecommended)
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.green.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(
//                             Icons.check_circle,
//                             size: 14,
//                             color: AppColors.green,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             'Recommended',
//                             style: AppStyle.regularSmallText.copyWith(
//                               fontSize: AppFontSize.f10,
//                               color: AppColors.green,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Specializes in routine maintenance.',
//                     style: AppStyle.regularSmallText.copyWith(
//                       fontSize: AppFontSize.f11,
//                       color: AppColors.textGrey,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildServiceDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Service Details',
//           style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f15),
//         ),
//         const SizedBox(height: 12),
//         _buildDetailRow('Service Type', 'Oil Change'),
//         const SizedBox(height: 8),
//         _buildDetailRow('Estimated Duration', '45 min'),
//         const SizedBox(height: 8),
//         _buildDetailRow('Estimated Cost', '\$65 - \$85', isPrice: true),
//       ],
//     );
//   }

//   Widget _buildDetailRow(String label, String value, {bool isPrice = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: AppStyle.regularSmallText.copyWith(
//             fontSize: AppFontSize.f12,
//             color: AppColors.iconGrey,
//           ),
//         ),
//         Text(
//           value,
//           style: AppStyle.boldSmallText.copyWith(
//             fontSize: AppFontSize.f13,
//             color: isPrice ? AppColors.cyanColor : AppColors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateSelector(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(
//               Icons.calendar_today,
//               size: 18,
//               color: AppColors.cyanColor,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Select Date',
//               style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f14),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         GestureDetector(
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: DateTime(2026, 7, 27),
//               firstDate: DateTime.now(),
//               lastDate: DateTime(2027, 12, 31),
//             );
//             if (picked != null) {
//               setState(() {
//                 _selectedDate =
//                     '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
//               });
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               border: Border.all(color: AppColors.grey.withOpacity(0.3)),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   _selectedDate,
//                   style: AppStyle.regularSmallText.copyWith(
//                     fontSize: AppFontSize.f13,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.calendar_today,
//                   size: 18,
//                   color: AppColors.iconGrey,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTimeSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Icon(Icons.access_time, size: 18, color: AppColors.cyanColor),
//             const SizedBox(width: 8),
//             Text(
//               'Select Time',
//               style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f14),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: _timeSlots.map((time) {
//             final isSelected = _selectedTime == time;
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedTime = time;
//                 });
//               },
//               child: Container(
//                 width: (SizeConfig.width(context) - 64) / 4,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: isSelected ? AppColors.cyanColor : AppColors.white,
//                   border: Border.all(
//                     color: isSelected
//                         ? AppColors.cyanColor
//                         : AppColors.grey.withOpacity(0.3),
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Center(
//                   child: Text(
//                     time,
//                     style: AppStyle.regularSmallText.copyWith(
//                       fontSize: AppFontSize.f12,
//                       color: isSelected ? AppColors.white : AppColors.black,
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildConfirmButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: _selectedTime == null
//             ? null
//             : () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       'Booking confirmed for $_selectedDate at $_selectedTime',
//                     ),
//                     backgroundColor: AppColors.green,
//                   ),
//                 );
//                 MyNavigation.navigateTo(WrapperPage());
//               },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.darkBlue,
//           disabledBackgroundColor: AppColors.grey.withOpacity(0.3),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Text(
//           'Confirm Booking',
//           style: AppStyle.boldSmallText.copyWith(
//             color: AppColors.white,
//             fontSize: AppFontSize.f14,
//           ),
//         ),
//       ),
//     );
//   }
// }
