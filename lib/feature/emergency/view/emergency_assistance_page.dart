import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
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
  String _locationText = AppConstants.locationLoading;
  bool _gpsActive = false;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    if (_isFetching) return;
    setState(() {
      _isFetching = true;
      _locationText = AppConstants.locationLoading;
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _gpsActive = false;
        _locationText = AppConstants.locationDisabled;
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
        _locationText = AppConstants.locationPermissionDenied;
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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppConstants.emergencyAssistance,
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
                decoration: BoxDecorationWidget.customBoxDecoration(
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
                            AppConstants.emergencyModeActive,
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f12,
                              color: AppColors.red,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            AppConstants.helpOnTheWay,
                            style: AppStyle.containerSubtitle.copyWith(
                              fontSize: AppFontSize.f11,
                              color: AppColors.iconGrey,
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
                  decoration: BoxDecorationWidget.customBoxDecoration(
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: AppColors.white),
                  child: Column(
                    children: [
                      Text(
                        AppConstants.emergencySos,
                        style: AppStyle.boldSmallText.copyWith(
                          fontSize: AppFontSize.f12,
                          color: AppColors.textGrey,
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
                            const Icon(
                              Icons.phone_in_talk,
                              color: AppColors.white,
                              size: 32,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              AppConstants.sos,
                              style: AppStyle.boldSmallText.copyWith(
                                fontSize: AppFontSize.f12,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppConstants.tapToCallEmergency,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f11,
                          color: AppColors.iconGrey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppConstants.emergencyNote,
                        textAlign: TextAlign.center,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color: AppColors.iconGrey,
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
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
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
                            AppConstants.currentLocation,
                            style: AppStyle.boldSmallText.copyWith(
                              fontSize: AppFontSize.f12,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _locationText,
                            style: AppStyle.containerSubtitle.copyWith(
                              fontSize: AppFontSize.f11,
                              color: AppColors.iconGrey,
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
                            ? AppConstants.gpsActive
                            : AppConstants.gpsInactive,
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
                AppConstants.quickActions,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f11,
                  color: AppColors.iconGrey,
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
                    label: AppConstants.towService,
                    color: AppColors.cyanColor,
                    onTap: () => _showTowOptions(context),
                  ),
                  _QuickAction(
                    icon: Icons.local_hospital,
                    label: AppConstants.ambulance,
                    color: AppColors.red,
                    onTap: () => _callNumber(AppConstants.ambulanceNumber),
                  ),
                  _QuickAction(
                    icon: Icons.shield_outlined,
                    label: AppConstants.police,
                    color: AppColors.blue,
                    onTap: () => _callNumber(AppConstants.policeNumber),
                  ),
                  _QuickAction(
                    icon: Icons.local_fire_department_outlined,
                    label: AppConstants.fireTruck,
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
      backgroundColor: AppColors.white,
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
                AppConstants.towHelp,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f14,
                ),
              ),
              const SizedBox(height: 12),
              _TowOption(
                title: AppConstants.helpoo,
                number: AppConstants.helpooNumber,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppConstants.egTowing,
                number: AppConstants.egTowingNumber1,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppConstants.egTowing,
                number: AppConstants.egTowingNumber2,
                onTap: _callNumber,
              ),
              _TowOption(
                title: AppConstants.mercedesRoadside,
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
              color: AppColors.textGrey,
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
          color: AppColors.iconGrey,
        ),
      ),
      trailing: const Icon(Icons.call, color: AppColors.cyanColor, size: 18),
      onTap: () => onTap(number),
    );
  }
}
