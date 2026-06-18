import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/booking_details/view/reschedule_booking_page.dart';
import 'package:driver_mate/feature/booking_details/view/widget/icon_label_value_widget.dart';
import 'package:driver_mate/feature/booking_details/view/widget/info_row.dart';
import 'package:driver_mate/feature/booking_details/view/widget/label_text_widget.dart';
import 'package:driver_mate/feature/booking_details/view/widget/section_card.dart';
import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/maintance_history/manager/state/maintence_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key, required this.booking});

  final MaintanceHistoryModel booking;

  // ── helpers ────────────────────────────────────────────────────────────────

  Color _statusColor() {
    switch (booking.state.toLowerCase()) {
      case 'upcoming':
        return AppColors.cyanColor;
      case 'completed':
        return AppColors.green;
      case 'cancelled':
        return AppColors.red;
      default:
        return AppColors.orange;
    }
  }

  Color _statusBgColor() => _statusColor().withValues(alpha: 0.1);

  String _formattedDate() {
    final d = booking.date;
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

  // ── actions ────────────────────────────────────────────────────────────────

  void _reschedule(BuildContext context) {
    MyNavigation.navigateTo(RescheduleBookingPage(booking: booking));
    AppNotifier.show(
      context,
      'Reschedule feature coming soon',
      type: NotifierType.warning,
    );
  }

  Future<void> _callCenter(BuildContext context) async {
    final uri = Uri.parse("tel:${booking.phone}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      AppNotifier.show(
        context,
        'Unable to open dialer',
        type: NotifierType.error,
      );
    }
  }

  void _cancelBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Cancel Booking',
          style: AppStyle.titleForContainer.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        content: Text(
          'Are you sure you want to cancel this booking?',
          style: AppStyle.containerSubtitle.copyWith(
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppStrings.of(context).cancel,
              style: AppStyle.viewAll.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<MaintenceHistoryCubit>().removeItem(booking);
              AppNotifier.show(
                context,
                'Booking cancelled successfully',
                type: NotifierType.error,
              );
              MyNavigation.navigateBack();
            },
            child: Text(
              'Cancel Booking',
              style: AppStyle.viewAll.copyWith(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
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
          'Booking Details',
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        leading: const LeadingIcon(),
      ),
      body: BlocListener<MaintenceHistoryCubit, MaintenceHistoryState>(
        listener: (context, state) {
          // react to state changes if needed
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.043,
            vertical: SizeConfig.height(context) * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── 1. Header card ─────────────────────────────────────────────
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.centerName,
                      style: AppStyle.titleForContainer.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.typeOfService,
                      style: AppStyle.containerSubtitle.copyWith(
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Status chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _statusBgColor(),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _statusColor().withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: _statusColor(),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            booking.state,
                            style: AppStyle.containerSubtitle.copyWith(
                              color: _statusColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Divider(color: Theme.of(context).dividerColor),
                    const SizedBox(height: 12),

                    // Date & Time
                    InfoRow(
                      icon: Icons.calendar_month_outlined,
                      label: 'DATE & TIME',
                      value: '${_formattedDate()} • ${booking.time}',
                    ),
                    const SizedBox(height: 12),

                    // Location
                    InfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'LOCATION',
                      value: booking.location,
                    ),
                    const SizedBox(height: 12),

                    // Price
                    InfoRow(
                      icon: Icons.attach_money_outlined,
                      label: 'PRICE',
                      value: '\$${booking.price.toStringAsFixed(0)}',
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              // ── 2. Service Details card ────────────────────────────────────
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service Details', style: AppStyle.titleForContainer),
                    const SizedBox(height: 16),

                    // Description
                    LabelText(label: 'DESCRIPTION'),
                    const SizedBox(height: 6),
                    Text(
                      'Complete ${booking.typeOfService.toLowerCase()} service '
                      'including a comprehensive multi-point inspection.',
                      style: AppStyle.containerSubtitle.copyWith(
                        color: Theme.of(context).iconTheme.color,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Estimated duration
                    IconLabelValue(
                      icon: Icons.access_time,
                      label: 'ESTIMATED DURATION',
                      value: '45 minutes',
                    ),
                    const SizedBox(height: 12),

                    // Technician
                    IconLabelValue(
                      icon: Icons.person_outline,
                      label: 'TECHNICIAN',
                      value: 'Not assigned yet',
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              // ── 3. Actions ─────────────────────────────────────────────────
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Actions', style: AppStyle.titleForContainer),
                    const SizedBox(height: 16),

                    // Reschedule (primary)
                    PrimaryElevatedButtonWidget(
                      buttonText: 'Reschedule Booking',
                      onPressed: () => _reschedule(context),
                    ),
                    const SizedBox(height: 10),

                    // Contact Center (outlined)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () => _callCenter(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.cyanColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.phone_outlined,
                          color: AppColors.cyanColor,
                          size: 18,
                        ),
                        label: Text(
                          'Contact Center',
                          style: AppStyle.boldSmallText.copyWith(
                            color: AppColors.cyanColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Cancel (outlined red) — only show when not cancelled
                    if (booking.state.toLowerCase() != 'cancelled')
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => _cancelBooking(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel Booking',
                            style: AppStyle.boldSmallText.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              // ── 4. Reminder banner ─────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cyanColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cyanColor.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.cyanColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reminder',
                            style: AppStyle.titleOfContainer.copyWith(
                              color: AppColors.cyanColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Please arrive 10 minutes before your scheduled time. '
                            'Bring your vehicle registration and any relevant documents.',
                            style: AppStyle.containerSubtitle.copyWith(
                              color: AppColors.textGrey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
