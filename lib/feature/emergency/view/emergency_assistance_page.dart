import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyAssistancePage extends StatefulWidget {
  const EmergencyAssistancePage({super.key});

  @override
  State<EmergencyAssistancePage> createState() =>
      _EmergencyAssistancePageState();
}

class _EmergencyAssistancePageState extends State<EmergencyAssistancePage> {
  bool _gpsActive = false;
  bool _isFetching = false;

    String _locationText = AppConstants.locationLoading;
  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    if (_isFetching) return;
    setState(() {
      _isFetching = true;
      _locationText = AppStrings.of(context).locationLoading;
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _gpsActive = false;
        _locationText = AppStrings.of(context).locationDisabled;
        _isFetching = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _gpsActive = false;
        _locationText = AppStrings.of(context).locationPermissionDenied;
        _isFetching = false;
      });
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _gpsActive = true;
      _locationText =
          "${AppConstants.lat} ${position.latitude.toStringAsFixed(5)}, "
          "${AppConstants.lng} ${position.longitude.toStringAsFixed(5)}";
      _isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          AppStrings.of(context).emergencyAssistance,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(context,
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.red.withValues(alpha: 0.1)),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.red.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sensors_off,
                        color: AppColors.red,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.of(context).emergencyModeActive,
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f12,
                              color: AppColors.red,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AppStrings.of(context).helpOnTheWay,
                            style: AppStyle.containerSubtitle.copyWith(
                              fontSize: AppFontSize.f11,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              GestureDetector(
                onTap: () => _callNumber(AppConstants.policeNumber),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecorationWidget.customBoxDecoration(context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.of(context).emergencySos,
                        style: AppStyle.boldSmallText.copyWith(
                          fontSize: AppFontSize.f12,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.red.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Icon(
                              Icons.phone_in_talk,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              size: 32,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              AppStrings.of(context).sos,
                              style: AppStyle.boldSmallText.copyWith(
                                fontSize: AppFontSize.f12,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppStrings.of(context).tapToCallEmergency,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f11,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.of(context).emergencyNote,
                        textAlign: TextAlign.center,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color:Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              InkWell(
                onTap: _loadLocation,
                borderRadius: BorderRadius.circular(AppFontSize.f12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecorationWidget.customBoxDecoration(context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.green.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.green,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.of(context).currentLocation,
                              style: AppStyle.boldSmallText.copyWith(
                                fontSize: AppFontSize.f12,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _locationText,
                              style: AppStyle.containerSubtitle.copyWith(
                                fontSize: AppFontSize.f11,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _gpsActive
                              ? AppColors.smoothGreen
                              : AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          _gpsActive
                              ? AppStrings.of(context).gpsActive
                              : AppStrings.of(context).gpsInactive,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f10,
                            color: _gpsActive
                                ? AppColors.green
                                : AppColors.iconGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppStrings.of(context).quickActions,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f11,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 18,
                runSpacing: 12,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  _QuickAction(
                    icon: Icons.local_shipping,
                    label: AppStrings.of(context).towService,
                    color: AppColors.cyanColor,
                    onTap: () => _showTowOptions(context),
                  ),
                  _QuickAction(
                    icon: Icons.local_hospital,
                    label: AppStrings.of(context).ambulance,
                    color: AppColors.red,
                    onTap: () => _callNumber(AppConstants.ambulanceNumber),
                  ),
                  _QuickAction(
                    icon: Icons.shield_outlined,
                    label: AppStrings.of(context).police,
                    color: AppColors.blue,
                    onTap: () => _callNumber(AppConstants.policeNumber),
                  ),
                  _QuickAction(
                    icon: Icons.local_fire_department_outlined,
                    label: AppStrings.of(context).fireTruck,
                    color: AppColors.orange,
                    onTap: () => _callNumber(AppConstants.fireTruckNumber),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callNumber(String number) async {
    final directCalled = await FlutterPhoneDirectCaller.callNumber(number);
    if (directCalled == true) {
      return;
    }
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showTowOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppFontSize.f16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.of(context).towHelp,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f14,
                  color: Theme.of(context).textTheme.bodyLarge?.color
                ),
              ),
              const SizedBox(height: 12),
              _TowOption(
                title: AppStrings.of(context).helpoo,
                number: AppConstants.helpooNumber,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppStrings.of(context).egTowing,
                number: AppConstants.egTowingNumber1,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppStrings.of(context).egTowing,
                number: AppConstants.egTowingNumber2,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppStrings.of(context).mercedesRoadside,
                number: AppConstants.mercedesNumber,
                onTap: _callNumber,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f10,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TowOption extends StatelessWidget {
  const _TowOption({
    required this.title,
    required this.number,
    required this.onTap,
  });

  final String title;
  final String number;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f12),
      ),
      subtitle: Text(
        number,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f11,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      trailing: const Icon(Icons.call, color: AppColors.cyanColor, size: 18),
      onTap: () => onTap(number),
    );
  }
}
