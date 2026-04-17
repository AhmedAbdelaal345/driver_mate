import 'dart:developer';
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

  Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
    required String image,
    required String accessToken,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      await pref.setString(SharedKey.name, name);
      await pref.setString(SharedKey.email, email);
      await pref.setString(SharedKey.phone, phone);
      await pref.setString(SharedKey.image, image);
      await pref.setString(SharedKey.accessToken, accessToken);
    } on Exception catch (e) {
      log('saveProfile error: $e');
    }
  }

  Future<EditProfileModel> getProfile() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final accessToken = pref.getString(SharedKey.accessToken) ?? '';

      ApiConstants.accessToken = accessToken;
      final ApiHelper apiHelper = ApiHelper();
      final ApiResponse response = await apiHelper.getRequest(
        endpoint: ApiConstants.profileEndpoint,
        isAuthorized: true,
        isForm: false,
      );

      // API response is the source of truth; fall back to local cache
      return EditProfileModel(
        fullName: response.data[ApiKeys.fullname]
            ?? pref.getString(SharedKey.name)
            ?? 'Unknown',
        emailAddress: response.data[ApiKeys.email]
            ?? pref.getString(SharedKey.email)
            ?? 'Unknown',
        image: response.data[ApiKeys.image]
            ?? pref.getString(SharedKey.image)
            ?? AppImagePath.defaultProfileImagePath,
        phoneNumber: response.data[ApiKeys.phone]
            ?? pref.getString(SharedKey.phone)
            ?? '',
        accessToken: response.data[ApiKeys.accessToken]
            ?? accessToken,
      );
    } on Exception catch (e) {
      log('getProfile error: $e');
      return EditProfileModel(
        fullName: 'Unknown',
        emailAddress: 'Unknown',
        image: AppImagePath.defaultProfileImagePath,
        phoneNumber: '',
        accessToken: '',
      );
    }
  }

  // ✅ changeProfile now owns persistence — cubit doesn't need to call saveProfile separately
  Future<EditProfileModel> changeProfile({
    required String fullName,
    required String emailAddress,
    required String image,
    required String phoneNumber,
    required String accessToken,
  }) async {
    // TODO: replace with real API PUT/PATCH call
    final updated = EditProfileModel(
      fullName: fullName,
      emailAddress: emailAddress,
      image: image,
      phoneNumber: phoneNumber,
      accessToken: accessToken,
    );

    await saveProfile(
      name: fullName,
      email: emailAddress,
      phone: phoneNumber,
      image: image,
      accessToken: accessToken,
    );

    return updated;
  }

  Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}