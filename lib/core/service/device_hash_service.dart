import 'dart:math';

import 'package:driver_mate/core/local/shared_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Generates and caches a stable, random device identifier.
///
/// The value is created once (on first launch) and stored in
/// SharedPreferences so that every subsequent request sends the
/// same hash — satisfying the server's `X-device-Hash` header.
class DeviceHashService {
  DeviceHashService._();

  static String _hash = '';

  /// Call once in `main()` before `runApp`.
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(SharedKey.deviceHash);
    if (stored != null && stored.isNotEmpty) {
      _hash = stored;
      return;
    }

    // Generate a random 32-char hex string (128 bits of entropy).
    final rng = Random.secure();
    final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
    _hash = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    await prefs.setString(SharedKey.deviceHash, _hash);
  }

  /// The device hash to send as `X-device-Hash`.
  static String get hash => _hash;
}
