import 'dart:developer';
import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class MaintenanceMapPage extends StatefulWidget {
  const MaintenanceMapPage({super.key, required this.centers});

  final List<ServiceCenterModel> centers;

  @override
  State<MaintenanceMapPage> createState() => _MaintenanceMapPageState();
}

class _MaintenanceMapPageState extends State<MaintenanceMapPage>
    with AutomaticKeepAliveClientMixin {
  late MapController controller;
  GeoPoint? _currentLocation;
  bool _isLoading = true;
  bool _initialized = false;
  int? _selectedIndex;
  bool _isNavigating = false; // tracks if a route is drawn

  MarkerIcon _buildUserMarker() {
    return MarkerIcon(
      iconWidget: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.cyanColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyanColor.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(Icons.person_rounded, color: Colors.white, size: 30),
      ),
    );
  }

  MarkerIcon _buildCenterMarker() {
    return MarkerIcon(
      iconWidget: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(Icons.build_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = MapController.withPosition(
      initPosition: GeoPoint(latitude: 30.0444, longitude: 31.2357),
    );
  }

  Future<void> _onMapReady() async {
    if (_initialized) return;
    _initialized = true;
    await _loadMapData();
  }

  Future<void> _loadMapData() async {
    try {
      setState(() => _isLoading = true);

      final hasPermission = await _checkLocationPermission();
      if (!hasPermission) {
        setState(() => _isLoading = false);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = GeoPoint(
        latitude: position.latitude,
        // 30.06263, // 
        longitude: position.longitude, //31.24967
      );

      await controller.goToLocation(_currentLocation!);
      await controller.setZoom(zoomLevel: 14);

      await controller.addMarker(
        _currentLocation!,
        markerIcon: _buildUserMarker(),
      );

      for (final center in widget.centers) {
        await controller.addMarker(
          center.location,
          markerIcon: _buildCenterMarker(),
        );
      }

      setState(() => _isLoading = false);
    } catch (e) {
      log(e.toString());
      AppNotifier.show(context, e.toString(), type: NotifierType.error);
      setState(() => _isLoading = false);
    }
  }

  Future<bool> _checkLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    return permission != LocationPermission.deniedForever;
  }

  // ── Recenter to user location ────────────────────────────────
  Future<void> _recenterToMyLocation() async {
    if (_currentLocation == null) return;
    await controller.goToLocation(_currentLocation!);
    await controller.setZoom(zoomLevel: 14);
  }

  // ── Navigate to selected service center ──────────────────────
  Future<void> _drawRouteTo(GeoPoint destination) async {
    if (_currentLocation == null) return;
    try {
      await controller.clearAllRoads();

      await controller.drawRoad(
        _currentLocation!,
        destination,
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadColor: AppColors.cyanColor,
          roadWidth: 15, // wider route line
          zoomInto: true, // auto-fits both points
        ),
      );

      // After road is drawn, zoom into street level at destination
      await Future.delayed(const Duration(milliseconds: 600));
      await controller.setZoom(zoomLevel: 17);

      setState(() => _isNavigating = true);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onCenterTapped(int index) async {
    setState(() => _selectedIndex = index);
    final center = widget.centers[index];
    await controller.goToLocation(center.location);
    await _drawRouteTo(center.location);
  }

  // ── Clear route and go back to overview ──────────────────────
  Future<void> _clearRoute() async {
    await controller.clearAllRoads();
    setState(() {
      _isNavigating = false;
      _selectedIndex = null;
    });
    await _recenterToMyLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        // ── Map takes most of the screen ──────────────────────
        Expanded(
          flex: 7, // 70% of screen height for the map
          child: Stack(
            children: [
              // ── Map ──────────────────────────────────────────
              OSMFlutter(
                controller: controller,
                onMapIsReady: (ready) {
                  if (ready) _onMapReady();
                },
                osmOption: const OSMOption(
                  zoomOption: ZoomOption(
                    initZoom: 14,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                  ),
                ),
              ),

              // ── Loading overlay ───────────────────────────────
              if (_isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.cyanColor,
                    ),
                  ),
                ),

              // ── Legend ────────────────────────────────────────
              if (!_isLoading)
                const Positioned(top: 16, right: 16, child: _MapLegend()),

              // ── My location button ────────────────────────────
              if (!_isLoading)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: _MapFab(
                    icon: Icons.my_location_rounded,
                    color: AppColors.cyanColor,
                    tooltip: 'My location',
                    onTap: _recenterToMyLocation,
                  ),
                ),

              // ── Clear route button (shown only while navigating)
              if (!_isLoading && _isNavigating)
                Positioned(
                  bottom: 80,
                  right: 16,
                  child: _MapFab(
                    icon: Icons.close_rounded,
                    color: Colors.redAccent,
                    tooltip: 'Clear route',
                    onTap: _clearRoute,
                  ),
                ),
            ],
          ),
        ),

        // ── Bottom cards panel ────────────────────────────────
        if (!_isLoading && widget.centers.isNotEmpty)
          Expanded(
            flex: 3, // 30% of screen height for the cards
            child: Container(
              color: Colors.grey.shade100,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.centers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final center = widget.centers[index];
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => _onCenterTapped(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 210,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.cyanColor : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected
                              ? AppColors.cyanColor
                              : Colors.grey.shade200,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Header ───────────────────────────
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.orange.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.build_circle_rounded,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.orange,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  center.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // ── Distance ─────────────────────────
                          Row(
                            children: [
                              Icon(
                                Icons.near_me_rounded,
                                size: 13,
                                color: isSelected
                                    ? Colors.white70
                                    : AppColors.cyanColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${(center.distance / 1000).toStringAsFixed(1)} km away',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // ── Address ──────────────────────────
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 13,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.redAccent,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  center.address.trim().isEmpty
                                      ? 'Address not available'
                                      : center.address,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

// ── Floating action button for map ────────────────────────────────────────────
class _MapFab extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _MapFab({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 35),
        ),
      ),
    );
  }
}

// ── Legend ────────────────────────────────────────────────────────────────────
class _MapLegend extends StatelessWidget {
  const _MapLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LegendItem(
            icon: Icons.person_rounded,
            color: AppColors.cyanColor,
            label: 'Your location',
          ),
          SizedBox(height: 6),
          _LegendItem(
            icon: Icons.build_rounded,
            color: Colors.orange,
            label: 'Service center',
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _LegendItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }
}
