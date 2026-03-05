import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'dart:io';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/explore/view/explore_search_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/service_center_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/moc_map_view_widget.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/service_center_card.dart';
import 'package:driver_mate/feature/maintance_booking/view/widget/view_toggle_wiget.dart';
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

  final List<ServiceCenter> _centers = [
    ServiceCenter(
      name: "AutoCare Service Center",
      distance: "1.2 km",
      rating: "4.8",
      reviews: "(234)",
      status: AppConstants.openNow,
      services: ["Oil Change", "Brake Service", "Diagnostics"],
      onTap: () {
        MyNavigation.navigateTo(
          ServiceCenterPage(
            serviceCenterName: "AutoCare Service Center",
            address: "123 Auto Street, Cityville",
            holiday: "Closed on Sundays",
            phoneNumber: "+1 (555) 123-4567",
            serviceProvided: ["Oil Change", "Brake Service", "Diagnostics"],
            imagePath: AppImagePath.carImagePath,
            workingHours: "Mon-Sat: 8am-6pm, Sun: Closed",
          ),
        );
      },
    ),
    ServiceCenter(
      name: "QuickFix Auto Works",
      distance: "2.5 km",
      rating: "4.6",
      reviews: "(189)",
      status: AppConstants.openNow,
      services: ["Engine", "Tire Service", "AC Service"],
      onTap: () {
        MyNavigation.navigateTo(
          ServiceCenterPage(
            serviceCenterName: "QuickFix Auto Works",
            address: "456 Repair Ave, Townsville",
            holiday: "Closed on Sundays",
            phoneNumber: "+1 (555) 987-6543",
            serviceProvided: ["Engine", "Tire Service", "AC Service"],
            imagePath: AppImagePath.carImagePath,
            workingHours: "Mon-Sat: 9am-5pm, Sun: Closed",
          ),
        );
      },
    ),
    ServiceCenter(
      name: "ProTech Motors",
      distance: "3.8 km",
      rating: "4.9",
      reviews: "(312)",
      status: AppConstants.closed,
      services: ["Full Service", "Body Work", "Electrical"],
      onTap: () {
        MyNavigation.navigateTo(
          ServiceCenterPage(
            serviceCenterName: "ProTech Motors",
            address: "456 Repair Ave, Townsville",
            holiday: "Closed on Sundays",
            phoneNumber: "+1 (555) 987-6543",
            serviceProvided: ["Full Service", "Body Work", "Electrical"],
            imagePath: AppImagePath.bmwCarImagePath,
            workingHours: "Mon-Sat: 9am-5pm, Sun: Closed",
          ),
        );
      },
    ),
    ServiceCenter(
      name: "SpeedCare Garage",
      distance: "4.2 km",
      rating: "4.5",
      reviews: "(156)",
      status: AppConstants.openNow,
      services: ["Oil Change", "Suspension", "Battery"],
      onTap: () {
        MyNavigation.navigateTo(
          ServiceCenterPage(
            serviceCenterName: "SpeedCare Garage",
            address: "789 Service Rd, Villagetown",
            holiday: "Closed on Sundays",
            phoneNumber: "+1 (555) 555-1234",
            serviceProvided: ["Oil Change", "Suspension", "Battery"],
            imagePath: AppImagePath.carImagePath,
            workingHours: "Mon-Sat: 7am-7pm, Sun: Closed",
          ),
        );
      },
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
            onPressed: () {
              MyNavigation.navigateTo(ExploreSearchPage());
            },
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
            child: ViewToggle(
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
                ? MockMapView(
                    isLoading: _isOpeningMap,
                    onOpenMaps: _openNearbyCenters,
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * 0.05,
                      vertical: SizeConfig.height(context) * 0.01,
                    ),
                    itemBuilder: (context, index) {
                      return ServiceCenterCard(center: _centers[index]);
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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





