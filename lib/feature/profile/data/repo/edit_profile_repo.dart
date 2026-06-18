import 'dart:developer';
import 'dart:io';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/core/local/shared_key.dart';
import 'package:driver_mate/core/network/api_constants.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileRepo {
  EditProfileRepo._singleTone();
  static final instance = EditProfileRepo._singleTone();
  factory EditProfileRepo() => instance;

  // ─── Save to local cache ───────────────────────────────────────────────────
  Future<void> _cacheProfile({
    required String name,
    required String email,
    required String phone,
    required String image,
    required String accessToken,
  }) async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.setString(SharedKey.name, name);
      await pref.setString(SharedKey.email, email);
      await pref.setString(SharedKey.phone, phone);
      await pref.setString(SharedKey.image, image);
      await pref.setString(SharedKey.accessToken, accessToken);
    } on Exception catch (e) {
      log('_cacheProfile error: $e');
    }
  }

  // ─── Read from local cache (offline fallback) ──────────────────────────────
  Future<EditProfileModel> _getFromCache() async {
    final pref = await SharedPreferences.getInstance();
    return EditProfileModel(
      fullName: pref.getString(SharedKey.name) ?? 'Unknown',
      emailAddress: pref.getString(SharedKey.email) ?? 'Unknown',
      phoneNumber: pref.getString(SharedKey.phone) ?? '',
      image:
          pref.getString(SharedKey.image) ??
          AppImagePath.defaultProfileImagePath,
      accessToken: pref.getString(SharedKey.accessToken) ?? '',
    );
  }

  // ─── Get profile: API first, cache fallback when offline ──────────────────
  Future<EditProfileModel> getProfile() async {
    final pref = await SharedPreferences.getInstance();
    final accessToken = pref.getString(SharedKey.accessToken) ?? '';

    try {
      ApiConstants.accessToken = accessToken;
      final ApiResponse response = await ApiHelper().getRequest(
        endpoint: ApiConstants.profileEndpoint,
        isAuthorized: true,
        isForm: false,
      );

      // API response keys from your actual response:
      // { fullName, email, phoneNumber, profileImageUrl }
      final data = response.data;

      final model = EditProfileModel(
        fullName:
            data[ApiKeys.fullname] ??
            pref.getString(SharedKey.name) ??
            'Unknown',
        emailAddress:
            data[ApiKeys.email] ?? pref.getString(SharedKey.email) ?? 'Unknown',
        phoneNumber:
            data[ApiKeys.phone] ?? pref.getString(SharedKey.phone) ?? '',
        image:
            data[ApiKeys.image] ??
            pref.getString(SharedKey.image) ??
            AppImagePath.defaultProfileImagePath,
        accessToken: accessToken,
      );

      // Keep cache in sync with latest API data
      await _cacheProfile(
        name: model.fullName,
        email: model.emailAddress,
        phone: model.phoneNumber,
        image: model.image,
        accessToken: accessToken,
      );

      return model;
    } on SocketException {
      // No internet — silently fall back to cache
      log('getProfile: offline, using cached data');
      return _getFromCache();
    } on Exception catch (e) {
      log('getProfile error: $e');
      return _getFromCache();
    }
  }

  // ─── Update profile: PUT to API then update cache ─────────────────────────
  Future<EditProfileModel> changeProfile({
    required String fullName,
    required String phoneNumber,
    required String image,
    required String accessToken,
    // email is intentionally excluded — it cannot be changed
  }) async {
    try {
      ApiConstants.accessToken = accessToken;
      await ApiHelper().putRequest(
        endpoint: ApiConstants.profileEndpoint,
        isAuthorized: true,
        isForm: true,
        data: {
          ApiKeys.fullname: fullName,
          ApiKeys.phone: phoneNumber,
          ApiKeys.editImageProfile: image,
        },
      );
    } on SocketException {
      log('changeProfile: offline — local save only');
    } on Exception catch (e) {
      log('changeProfile API error: $e');
      rethrow; // let the cubit emit an error state
    }

    // Get the existing email from cache (it never changes)
    final pref = await SharedPreferences.getInstance();
    final email = pref.getString(SharedKey.email) ?? 'Unknown';

    // Always persist locally so offline reads are fresh
    await _cacheProfile(
      name: fullName,
      email: email,
      phone: phoneNumber,
      image: image,
      accessToken: accessToken,
    );

    return EditProfileModel(
      fullName: fullName,
      emailAddress: email,
      phoneNumber: phoneNumber,
      image: image,
      accessToken: accessToken,
    );
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
