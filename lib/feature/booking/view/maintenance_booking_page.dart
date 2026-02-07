import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class MaintenanceBookingPage extends StatefulWidget {
  const MaintenanceBookingPage({super.key});

  @override
  State<MaintenanceBookingPage> createState() => _MaintenanceBookingPageState();
}

class _MaintenanceBookingPageState extends State<MaintenanceBookingPage> {
  String _selectedDate = '07/27/2026';
  String? _selectedTime;

  final List<String> _timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Maintenance Booking', style: AppStyle.appBarTitle),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(SizeConfig.width(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Center Card
            _buildServiceCenterCard(),
            const SizedBox(height: 24),

            // Service Details Section
            _buildServiceDetails(),
            const SizedBox(height: 24),

            // Select Date
            _buildDateSelector(context),
            const SizedBox(height: 24),

            // Select Time
            _buildTimeSelector(),
            const SizedBox(height: 32),

            // Confirm Booking Button
            _buildConfirmButton(context),
            const SizedBox(height: 16),

            // Back Link
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Back',
                  style: AppStyle.regularSmallText.copyWith(
                    color: AppColors.cyanColor,
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCenterCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.cyanColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.build, color: AppColors.white, size: 28),
          ),
          const SizedBox(width: 12),

          // Service Center Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AutoCare Service Center',
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f14,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.cyanColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '2.5 km away • Downtown',
                      style: AppStyle.regularSmallText.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.iconGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 14,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Recommended for Oil Change',
                        style: AppStyle.regularSmallText.copyWith(
                          fontSize: AppFontSize.f10,
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Specializes in routine maintenance and engine diagnostics. Open Mon-Sat 9AM-6PM.',
                  style: AppStyle.regularSmallText.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Details',
          style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f15),
        ),
        const SizedBox(height: 12),
        _buildDetailRow('Service Type', 'Oil Change'),
        const SizedBox(height: 8),
        _buildDetailRow('Estimated Duration', '45 min'),
        const SizedBox(height: 8),
        _buildDetailRow('Estimated Cost', '\$65 - \$85', isPrice: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.regularSmallText.copyWith(
            fontSize: AppFontSize.f12,
            color: AppColors.iconGrey,
          ),
        ),
        Text(
          value,
          style: AppStyle.boldSmallText.copyWith(
            fontSize: AppFontSize.f13,
            color: isPrice ? AppColors.cyanColor : AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 18,
              color: AppColors.cyanColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Select Date',
              style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2026, 7, 27),
              firstDate: DateTime.now(),
              lastDate: DateTime(2027, 12, 31),
            );
            if (picked != null) {
              setState(() {
                _selectedDate =
                    '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate,
                  style: AppStyle.regularSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: AppColors.iconGrey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time, size: 18, color: AppColors.cyanColor),
            const SizedBox(width: 8),
            Text(
              'Select Time',
              style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f14),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _timeSlots.map((time) {
            final isSelected = _selectedTime == time;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTime = time;
                });
              },
              child: Container(
                width: (SizeConfig.width(context) - 64) / 4,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.cyanColor : AppColors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.cyanColor
                        : AppColors.grey.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: AppStyle.regularSmallText.copyWith(
                      fontSize: AppFontSize.f12,
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedTime == null
            ? null
            : () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking confirmed for $_selectedDate at $_selectedTime',
                    ),
                    backgroundColor: AppColors.green,
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          disabledBackgroundColor: AppColors.grey.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Confirm Booking',
          style: AppStyle.boldSmallText.copyWith(
            color: AppColors.white,
            fontSize: AppFontSize.f14,
          ),
        ),
      ),
    );
  }
}
