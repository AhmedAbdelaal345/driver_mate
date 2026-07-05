import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/booking_details/view/widget/booking_info_row_widget.dart';
import 'package:driver_mate/feature/booking_details/view/widget/section_card.dart';
import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RescheduleBookingPage extends StatefulWidget {
  const RescheduleBookingPage({super.key, required this.booking});

  final MaintanceHistoryModel booking;

  @override
  State<RescheduleBookingPage> createState() => _RescheduleBookingPageState();
}

class _RescheduleBookingPageState extends State<RescheduleBookingPage> {
  DateTime? _selectedDate;
  String? _selectedTime;
  String? _selectedVehicle;
  final TextEditingController _reasonController = TextEditingController();

  final List<String> _timeSlots = const [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  // Generate next 7 days starting today
  List<DateTime> get _dates {
    final today = DateTime.now();
    return List.generate(7, (i) => today.add(Duration(days: i)));
  }

  bool get _canConfirm =>
      _selectedDate != null &&
      _selectedTime != null &&
      _selectedVehicle != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VehicalCubit.get(context).fetchVehicles();
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  // ── formatted helpers ──────────────────────────────────────────────────────

  String _formatDayName(DateTime d) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[d.weekday - 1];
  }

  String _formatMonthName(DateTime d) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[d.month];
  }

  String _fullMonthName(DateTime d) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[d.month];
  }

  String _formatCurrentDate(DateTime d) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }

  // ── confirm action ─────────────────────────────────────────────────────────

  void _confirmReschedule() {
    if (!_canConfirm) {
      AppNotifier.show(
        context,
        AppStrings.of(context).pleaseSelectDateAndTime,
        type: NotifierType.warning,
      );
      return;
    }

    final updated = MaintanceHistoryModel(
      centerName: widget.booking.centerName,
      typeOfService: widget.booking.typeOfService,
      location: widget.booking.location,
      state: 'Upcoming',
      date: _selectedDate!,
      price: widget.booking.price,
      time: _selectedTime ?? "",
      phone: widget.booking.phone,
    );

    context.read<MaintenceHistoryCubit>().removeItem(widget.booking);
    context.read<MaintenceHistoryCubit>().addItem(updated);

    AppNotifier.show(
      context,

      // 'Booking rescheduled successfully!'
      AppStrings.of(context).bookingRescheduled,
      type: NotifierType.success,
    );
    // Pop twice — back past BookingDetailsPage to history
    MyNavigation.navigateBack();
    MyNavigation.navigateBack();
  }

  // ── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).rescheduleBooking,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.043,
          vertical: SizeConfig.height(context) * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Current Booking Info Banner ─────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cyanColor.withValues(alpha: 0.25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.of(context).currentBookingDetails,
                        style: AppStyle.titleOfContainer.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    // "You're rescheduling your appointment. Select a new date and time below."
                    AppStrings.of(context).rescheduleBookingNote,
                    style: AppStyle.containerSubtitle.copyWith(
                      color: Theme.of(context).iconTheme.color,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(color: Theme.of(context).dividerColor),
                  const SizedBox(height: 10),
                  BookingInfoRow(
                    label: 'Service Center',
                    value: widget.booking.centerName,
                  ),
                  const SizedBox(height: 8),
                  BookingInfoRow(
                    label: 'Service Type',
                    value: widget.booking.typeOfService,
                  ),
                  const SizedBox(height: 8),
                  BookingInfoRow(
                    label: 'Current Date',
                    value: _formatCurrentDate(widget.booking.date),
                    valueColor: AppColors.red,
                  ),
                  const SizedBox(height: 8),
                  BookingInfoRow(
                    label: 'Current Time',
                    value: widget.booking.time,
                    valueColor: AppColors.red,
                  ),
                  const SizedBox(height: 8),
                  BookingInfoRow(
                    label: 'Price',
                    value: '\$${widget.booking.price.toStringAsFixed(0)}',
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.025),

            // ── 2. Select New Date ─────────────────────────────────────────
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.of(context).selectNewDate,
                        style: AppStyle.titleOfContainer.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _dates.map((date) {
                        final isSelected =
                            _selectedDate != null &&
                            _selectedDate!.day == date.day &&
                            _selectedDate!.month == date.month;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedDate = date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            width: 56,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.cyanColor
                                    : AppColors.boarderWhiteColor,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _formatDayName(date),
                                  style: AppStyle.containerSubtitle.copyWith(
                                    color: isSelected
                                        ? AppColors.white.withValues(alpha: 0.8)
                                        : AppColors.midGrey,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${date.day}',
                                  style: AppStyle.titleOfContainer.copyWith(
                                    color: isSelected
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onSurface
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatMonthName(date),
                                  style: AppStyle.containerSubtitle.copyWith(
                                    color: isSelected
                                        ? AppColors.white.withValues(alpha: 0.8)
                                        : AppColors.midGrey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            // ── 3. Select New Time ─────────────────────────────────────────
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.of(context).selectNewTime,
                        style: AppStyle.titleOfContainer.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _timeSlots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2.6,
                        ),
                    itemBuilder: (context, index) {
                      final slot = _timeSlots[index];
                      final isSelected = _selectedTime == slot;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedTime = slot),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cyanColor
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.cyanColor
                                  : AppColors.boarderWhiteColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              slot,
                              style: AppStyle.containerSubtitle.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textGrey,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            // ── 4. Select Vehicle ──────────────────────────────────────────
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.of(context).selectVehicle,
                        style: AppStyle.titleOfContainer.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<VehicalCubit, VehicalState>(
                    builder: (context, state) {
                      if (state is LoadingVehicalState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      }
                      if (state is SuccessVehicalState &&
                          state.data.isNotEmpty) {
                        final vehicles = state.data;
                        // Auto-select first if none chosen
                        if (_selectedVehicle == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                _selectedVehicle =
                                    '${vehicles.first.brandName} ${vehicles.first.modelName} ${vehicles.first.year}';
                              });
                            }
                          });
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                              color: AppColors.boarderWhiteColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedVehicle,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              style: AppStyle.titleOfContainer.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                              onChanged: (val) =>
                                  setState(() => _selectedVehicle = val),
                              items: vehicles.map((v) {
                                final label = '${v.brandName} ${v.modelName} ${v.year}';
                                return DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                      return Text(
                        AppStrings.of(context).noVehiclesFound,
                        style: AppStyle.containerSubtitle.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            // ── 5. Reason (Optional) ───────────────────────────────────────
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.of(context).reasonForRescheduling,
                        style: AppStyle.titleOfContainer.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _reasonController,
                    maxLines: 3,
                    style: AppStyle.titleOfContainer,
                    decoration: InputDecoration(
                      hintText: AppStrings.of(context).rescheduleReasonHint,
                      hintStyle: AppStyle.containerSubtitle.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.height(context) * 0.02),

            // ── 6. New Appointment Summary (shows only when all selected) ──
            if (_canConfirm) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.of(context).newAppointmentDetails,
                      style: AppStyle.titleOfContainer.copyWith(
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BookingInfoRow(
                      label: AppStrings.of(context).newDate,
                      value:
                          '${_fullMonthName(_selectedDate!)} ${_selectedDate!.day}, ${_selectedDate!.year}',
                      valueColor: AppColors.green,
                    ),
                    const SizedBox(height: 8),
                    BookingInfoRow(
                      label: AppStrings.of(context).newTime,
                      value: _selectedTime!,
                      valueColor: AppColors.green,
                    ),
                    const SizedBox(height: 8),
                    BookingInfoRow(
                      label: AppStrings.of(context).vehicle,
                      value: _selectedVehicle!,
                      valueColor: AppColors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
            ],

            // ── 7. Confirm Button ──────────────────────────────────────────
            PrimaryElevatedButtonWidget(
              buttonText: AppStrings.of(context).confirmReschedule,
              onPressed: _canConfirm ? _confirmReschedule : null,
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                AppStrings.of(context).noAdditionalCharges,
                style: AppStyle.containerSubtitle.copyWith(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.height(context) * 0.04),
          ],
        ),
      ),
    );
  }
}
