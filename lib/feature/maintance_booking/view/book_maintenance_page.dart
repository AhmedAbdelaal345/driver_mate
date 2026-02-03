import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'dart:io';

import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class BookMaintenancePage extends StatefulWidget {
  const BookMaintenancePage({super.key});

  @override
  State<BookMaintenancePage> createState() => _BookMaintenancePageState();
}

class _BookMaintenancePageState extends State<BookMaintenancePage> {
  bool _isMapView = false;
  bool _isOpeningMap = false;

  final List<_ServiceCenter> _centers = const [
    _ServiceCenter(
      name: "AutoCare Service Center",
      distance: "1.2 km",
      rating: "4.8",
      reviews: "(234)",
      status: AppConstants.openNow,
      services: ["Oil Change", "Brake Service", "Diagnostics"],
    ),
    _ServiceCenter(
      name: "QuickFix Auto Works",
      distance: "2.5 km",
      rating: "4.6",
      reviews: "(189)",
      status: AppConstants.openNow,
      services: ["Engine", "Tire Service", "AC Service"],
    ),
    _ServiceCenter(
      name: "ProTech Motors",
      distance: "3.8 km",
      rating: "4.9",
      reviews: "(312)",
      status: AppConstants.closed,
      services: ["Full Service", "Body Work", "Electrical"],
    ),
    _ServiceCenter(
      name: "SpeedCare Garage",
      distance: "4.2 km",
      rating: "4.5",
      reviews: "(156)",
      status: AppConstants.openNow,
      services: ["Oil Change", "Suspension", "Battery"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppConstants.bookMaintenance,
          style: AppStyle.appBarTitle,
        ),
        leading: const LeadingIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.iconGrey),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * 0.05,
              vertical: SizeConfig.height(context) * 0.01,
            ),
            child: _ViewToggle(
              isMapView: _isMapView,
              onChanged: (value) {
                setState(() {
                  _isMapView = value;
                });
              },
            ),
          ),
          Expanded(
            child: _isMapView
                ? _MockMapView(
                    isLoading: _isOpeningMap,
                    onOpenMaps: _openNearbyCenters,
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * 0.05,
                      vertical: SizeConfig.height(context) * 0.01,
                    ),
                    itemBuilder: (context, index) {
                      return _ServiceCenterCard(center: _centers[index]);
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: _centers.length,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _openNearbyCenters() async {
    if (_isOpeningMap) return;
    setState(() => _isOpeningMap = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showMessage(AppConstants.locationDisabled);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showMessage(AppConstants.locationPermissionDenied);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final uris = _buildMapUris(position.latitude, position.longitude);
      for (final uri in uris) {
        final launched = await _tryLaunch(uri);
        if (launched) {
          return;
        }
      }
      _showMessage(AppConstants.openMapsFailed);
    } catch (_) {
      _showMessage(AppConstants.openMapsFailed);
    } finally {
      if (mounted) {
        setState(() => _isOpeningMap = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<Uri> _buildMapUris(double lat, double lng) {
    final query = "car service center near $lat,$lng";
    final encoded = Uri.encodeComponent(query);
    final uris = <Uri>[];

    if (Platform.isAndroid) {
      uris.add(Uri.parse("google.navigation:q=$encoded"));
      uris.add(Uri.parse("geo:$lat,$lng?q=$encoded"));
    }

    if (Platform.isIOS) {
      uris.add(Uri.parse("comgooglemaps://?q=$encoded&center=$lat,$lng"));
      uris.add(Uri.parse("http://maps.apple.com/?q=$encoded&ll=$lat,$lng"));
    }

    uris.add(
      Uri.https("www.google.com", "/maps/search/", {
        "api": "1",
        "query": query,
      }),
    );
    uris.add(Uri.https("maps.google.com", "/", {"q": query}));
    return uris;
  }

  Future<bool> _tryLaunch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}

class _ViewToggle extends StatelessWidget {
  const _ViewToggle({
    required this.isMapView,
    required this.onChanged,
  });

  final bool isMapView;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.containerGrey),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              text: AppConstants.listView,
              icon: Icons.list,
              isActive: !isMapView,
              onTap: () => onChanged(false),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              text: AppConstants.mapView,
              icon: Icons.map_outlined,
              isActive: isMapView,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.text,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cyanColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppFontSize.f12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? AppColors.white : AppColors.textGrey,
            ),
            const SizedBox(width: 6),
            Text(
              text,
              style: AppStyle.boldSmallText.copyWith(
                fontSize: AppFontSize.f12,
                color: isActive ? AppColors.white : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MockMapView extends StatelessWidget {
  const _MockMapView({
    required this.onOpenMaps,
    required this.isLoading,
  });

  final VoidCallback onOpenMaps;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF16C9C9),
        borderRadius: BorderRadius.circular(AppFontSize.f12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_pin,
              size: 64,
              color: AppColors.red,
            ),
            const SizedBox(height: 6),
            Text(
              AppConstants.mapPreview,
              style: AppStyle.boldSmallText.copyWith(
                color: AppColors.white,
                fontSize: AppFontSize.f12,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: isLoading ? null : onOpenMaps,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.white.withValues(alpha: 0.7),
                foregroundColor: AppColors.cyanColor,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: Icon(
                Icons.map_outlined,
                size: 16,
                color: isLoading ? AppColors.iconGrey : AppColors.cyanColor,
              ),
              label: Text(
                isLoading ? AppConstants.openingMaps : AppConstants.openInMaps,
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f11,
                  color: isLoading ? AppColors.iconGrey : AppColors.cyanColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCenterCard extends StatelessWidget {
  const _ServiceCenterCard({required this.center});

  final _ServiceCenter center;

  @override
  Widget build(BuildContext context) {
    final isOpen = center.status == AppConstants.openNow;
    final statusColor = isOpen ? AppColors.green : AppColors.iconGrey;
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    center.name,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    center.status,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.iconGrey,
                ),
                const SizedBox(width: 4),
                Text(
                  center.distance,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.star,
                  size: 14,
                  color: AppColors.orange,
                ),
                const SizedBox(width: 4),
                Text(
                  "${center.rating} ${center.reviews}",
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.iconGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: center.services
                  .map(
                    (service) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        service,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  AppConstants.viewDetails,
                  style: AppStyle.viewAll.copyWith(
                    fontSize: AppFontSize.f12,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.iconGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCenter {
  const _ServiceCenter({
    required this.name,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.status,
    required this.services,
  });

  final String name;
  final String distance;
  final String rating;
  final String reviews;
  final String status;
  final List<String> services;
}
