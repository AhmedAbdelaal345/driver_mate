import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
// import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/home/view/wrapper_page.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/date_selector.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/empty_vehicle_state.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/header_section.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/note_textfield.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/service_center_info_card.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/time_selector.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/vehicle_selector.dart';
import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentPage extends StatefulWidget {
  const BookAppointmentPage({super.key, required this.serviceCenter});

  final ServiceCenterModel serviceCenter;

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime? _selectedDate;
  String? _selectedTime;
  VechicleModel? _selectedVehicle;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _timeSlots = const [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    // Load vehicles when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      VehicalCubit.get(context).fetchVehicles();
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool get _canConfirmBooking {
    return _selectedDate != null &&
        _selectedTime != null &&
        _selectedVehicle != null;
  }

  Future<void> _confirmBooking() async {
    if (!_canConfirmBooking || _isBooking) return;

    setState(() {
      _isBooking = true;
    });

    try {
      context.read<MaintenceHistoryCubit>().addItem(
        MaintanceHistoryModel(
          centerName: widget.serviceCenter.name,
          typeOfService: widget.serviceCenter.services.join(", "),
          location: widget.serviceCenter.address,
          state: _selectedDate!.isAfter(DateTime.now())
              ? "Upcoming"
              : "Completed",
          date: _selectedDate ?? DateTime.now(),
          time: _selectedTime ?? "No Time",
          price: 10,
          notes: _notesController.text.trim(),
          phone: widget.serviceCenter.phone,
        ),
      );

      AppNotifier.show(
        context,
        'Booking confirmed for ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} at $_selectedTime',
        type: NotifierType.success,
      );

      MyNavigation.navigateTo(WrapperPage(initialIndex: 2));
    } finally {
      if (mounted) {
        setState(() {
          _isBooking = false;
        });
      }
    }
  }

  bool _isBooking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          AppStrings.of(context).bookAppointment,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Center Info
              ServiceCenterInfoCard(serviceCenter: widget.serviceCenter),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              // Select Date Section
              SectionHeader(
                icon: Icons.calendar_month_outlined,
                title: AppStrings.of(context).selectDate,
              ),
              const SizedBox(height: 12),
              DateSelector(
                selectedDate: _selectedDate,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              // Select Time Section
              SectionHeader(
                icon: Icons.access_time,
                title: AppStrings.of(context).selectTime,
              ),
              const SizedBox(height: 12),
              TimeSelector(
                timeSlots: _timeSlots,
                selectedTime: _selectedTime,
                onTimeSelected: (time) {
                  setState(() {
                    _selectedTime = time;
                  });
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              // Select Vehicle Section
              SectionHeader(
                icon: Icons.directions_car_outlined,
                title: AppStrings.of(context).selectVehicle,
              ),
              const SizedBox(height: 12),
              BlocBuilder<VehicalCubit, VehicalState>(
                builder: (context, state) {
                  if (state is LoadingVehicalState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  }
                  if (state is SuccessVehicalState) {
                    if (state.data.isEmpty) {
                      return EmptyVehicleState();
                    }
                    return VehicleSelector(
                      vehicles: state.data,
                      selectedVehicle: _selectedVehicle,
                      onVehicleSelected: (vehicle) {
                        setState(() {
                          _selectedVehicle = vehicle;
                        });
                      },
                    );
                  }
                  return EmptyVehicleState();
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              // Additional Notes Section
              SectionHeader(
                icon: Icons.description_outlined,
                title: AppStrings.of(context).additionalNotes,
              ),
              const SizedBox(height: 12),
              NotesTextField(controller: _notesController),
              SizedBox(height: SizeConfig.height(context) * 0.03),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: PrimaryElevatedButtonWidget(
            onPressed: (_canConfirmBooking && !_isBooking)
                ? _confirmBooking
                : null,
            buttonText: _isBooking
                ? "Booking..."
                : AppStrings.of(context).confirmBooking,
          ),
        ),
      ),
    );
  }
}
