import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/maintance_booking/data/model/service_center_model.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class MaintenanceRepo {
  // ── Multiple endpoints tried in order ─────────────────────────────────────
  static const List<String> _endpoints = [
    'https://overpass-api.de/api/interpreter', // official — most reliable
    'https://maps.mail.ru/osm/tools/overpass/api/interpreter', // Russian mirror
    'https://overpass.openstreetmap.ru/api/interpreter', // secondary
  ];

  // ── Cached result so repeated calls don't re-fetch ────────────────────────
  List<ServiceCenterModel>? _cachedCenters;
  double? _cachedLat;
  double? _cachedLon;
  static const double _cacheRadiusMeters = 500; // re-fetch if user moved >500m

  // ── Optimized Dio instance ─────────────────────────────────────────────────
  late final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'User-Agent': 'DriverMateApp/1.0',
        'Accept': 'application/json',
      },
    ),
  );

  Future<List<ServiceCenterModel>> getNearbyCenters() async {
    // ── 1. Get current position ──────────────────────────────────────────────
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final lat = //30.06263; 
    position.latitude;   // swap back from static coords
    final lon = //31.24967; 
    position.longitude;

    // ── 2. Return cache if user hasn't moved much ────────────────────────────
    if (_cachedCenters != null && _cachedLat != null && _cachedLon != null) {
      final moved = Geolocator.distanceBetween(
        _cachedLat!,
        _cachedLon!,
        lat,
        lon,
      );
      if (moved < _cacheRadiusMeters) {
        print(
          'MaintenanceRepo: returning ${_cachedCenters!.length} cached centers',
        );
        return _cachedCenters!;
      }
    }

    // ── 3. Build lean query — union of node+way in one pass ──────────────────
    const radius = 20000;
    final query =
        '''
[out:json][timeout:20];
(
  node["shop"="car_repair"](around:$radius,$lat,$lon);
  way["shop"="car_repair"](around:$radius,$lat,$lon);
  node["craft"="car_repair"](around:$radius,$lat,$lon);
  way["craft"="car_repair"](around:$radius,$lat,$lon);
  node["amenity"="car_repair"](around:$radius,$lat,$lon);
  way["amenity"="car_repair"](around:$radius,$lat,$lon);
  node["shop"="tyres"](around:$radius,$lat,$lon);
  way["shop"="tyres"](around:$radius,$lat,$lon);
);
out body center qt;
''';
    // `qt` = skip sorting on server side (faster), we sort client-side

    // ── 4. Try each endpoint until one succeeds ───────────────────────────────
    Response? response;
    String? lastError;

    for (final endpoint in _endpoints) {
      try {
        print('MaintenanceRepo: trying $endpoint');

        response = await _dio.post(
          endpoint,
          data: 'data=${Uri.encodeComponent(query)}',
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.plain,
            validateStatus: (status) => true,
          ),
        );

        if (response.statusCode == 200) {
          print('MaintenanceRepo: success from $endpoint');
          break; // got a good response — stop trying
        }

        lastError = 'HTTP ${response.statusCode} from $endpoint';
        print('MaintenanceRepo: $lastError');
        response = null; // don't use this response
      } on DioException catch (e) {
        lastError = _friendlyDioError(e, endpoint);
        print('MaintenanceRepo: $lastError');
        response = null; // try next
      }
    }

    // ── 5. All endpoints failed ───────────────────────────────────────────────
    if (response == null) {
      throw Exception(
        'Could not reach any Overpass server.\n'
        'Last error: $lastError\n'
        'Check your internet connection and try again.',
      );
    }

    // ── 6. Parse response ─────────────────────────────────────────────────────
    final List<ServiceCenterModel> centers = _parseElements(
      response.data as String,
      lat,
      lon,
    );

    // ── 7. Cache and return ───────────────────────────────────────────────────
    _cachedCenters = centers;
    _cachedLat = lat;
    _cachedLon = lon;

    print('MaintenanceRepo: found ${centers.length} centers');
    return centers;
  }

  // ── Parse Overpass JSON into models ─────────────────────────────────────────
  List<ServiceCenterModel> _parseElements(
    String rawJson,
    double userLat,
    double userLon,
  ) {
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    final elements = decoded['elements'] as List? ?? [];

    final List<ServiceCenterModel> centers = [];

    for (final element in elements) {
      try {
        final type = element['type'] as String?;
        double? lat2;
        double? lon2;

        if (type == 'way') {
          final center = element['center'] as Map<String, dynamic>?;
          if (center == null) continue; // way without center — skip
          lat2 = (center['lat'] as num).toDouble();
          lon2 = (center['lon'] as num).toDouble();
        } else if (type == 'node') {
          lat2 = (element['lat'] as num?)?.toDouble();
          lon2 = (element['lon'] as num?)?.toDouble();
        }

        if (lat2 == null || lon2 == null) continue;

        final tags = (element['tags'] as Map<String, dynamic>?) ?? {};
        final distance = Geolocator.distanceBetween(
          userLat,
          userLon,
          lat2,
          lon2,
        );
        final address = [
          tags['addr:street'] ?? '',
          tags['addr:city'] ?? '',
        ].where((s) => s.isNotEmpty).join(', ');

        centers.add(
          ServiceCenterModel(
            name: tags['name'] ?? tags['brand'] ?? 'Service Center',
            location: GeoPoint(latitude: lat2, longitude: lon2),
            distance: distance,
            imagePath: AppImagePath.camryCarImagePath,
            address: address.isEmpty ? 'Address not available' : address,
            phone:
                tags['phone'] ??
                tags['contact:phone'] ??
                tags['contact:mobile'] ??
                'Not available',
            workingHours: tags['opening_hours'] ?? 'Not available',
            services: _inferServices(tags),
          ),
        );
      } catch (e) {
        // Skip malformed elements — don't crash the whole list
        print('MaintenanceRepo: skipped malformed element: $e');
        continue;
      }
    }

    centers.sort((a, b) => a.distance.compareTo(b.distance));
    return centers;
  }

  // ── Infer services from OSM tags ─────────────────────────────────────────
  List<String> _inferServices(Map<String, dynamic> tags) {
    final services = <String>['Car Repair'];
    final shop = tags['shop'] as String? ?? '';
    final craft = tags['craft'] as String? ?? '';

    if (shop == 'tyres' || tags['service:tyres'] == 'yes') {
      services.add('Tyre Service');
    }
    if (tags['service:oil_change'] == 'yes') {
      services.add('Oil Change');
    }
    if (tags['service:battery'] == 'yes') {
      services.add('Battery');
    }
    if (craft == 'painter' || tags['service:painting'] == 'yes') {
      services.add('Painting');
    }
    return services;
  }

  // ── Human-readable Dio error ──────────────────────────────────────────────
  String _friendlyDioError(DioException e, String endpoint) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout to $endpoint';
      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond: $endpoint';
      case DioExceptionType.sendTimeout:
        return 'Request send timeout to $endpoint';
      case DioExceptionType.connectionError:
        return 'No internet or DNS failure: $endpoint';
      default:
        return '${e.message} from $endpoint';
    }
  }

  // ── Manually clear cache (e.g. pull-to-refresh) ───────────────────────────
  void clearCache() {
    _cachedCenters = null;
    _cachedLat = null;
    _cachedLon = null;
  }
}
