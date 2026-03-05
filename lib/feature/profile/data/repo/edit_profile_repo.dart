import 'dart:developer';

import 'package:driver_mate/core/local/shared_key.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileRepo {
  EditProfileRepo._singleTone();
  static final instance = EditProfileRepo._singleTone();
  factory EditProfileRepo() {
    return instance;
  }

  Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
    required String image,
  }) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    try {
      await pref.setString(SharedKey.name, name);
      await pref.setString(SharedKey.email, email);
      await pref.setString(SharedKey.phone, phone);
      await pref.setString(SharedKey.image, image);
    } on Exception catch (e) {
      log("there is exception when saving profile data: $e");
    }
  }

  Future<EditProfileModel?> getProfile() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      final name = pref.getString(SharedKey.name);
      final email = pref.getString(SharedKey.email);
      final phone = pref.getString(SharedKey.phone);
      final image = pref.getString(SharedKey.image);

      if (name == null || email == null) {
        return null;
      }

      return EditProfileModel(
        fullName: name,
        emailAddress: email,
        image: image ?? "",
        phoneNumber: phone ?? "",
      );
    } on Exception catch (e) {
      log(e.toString(), name: "there is exception when getting profile data");
      return EditProfileModel(
        fullName: "Unknown",
        emailAddress: "Unknown",
        image: "Unknown",
        phoneNumber: "Unknown",
      );
    }
  }

  Future<EditProfileModel> changeProfile({
    required String fullName,
    required String emailAddress,
    required String image,
    required String phoneNumber,
  }) async {
    Future.delayed(Duration(seconds: 2));
    return EditProfileModel(
      fullName: fullName,
      emailAddress: emailAddress,
      image: image,
      phoneNumber: phoneNumber,
    );
  }
}
