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
    await pref.setString(SharedKey.name, name);
    await pref.setString(SharedKey.email, email);
    await pref.setString(SharedKey.phone, phone);
    await pref.setString(SharedKey.image, image);
  }

  Future<EditProfileModel?> getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final name = await pref.getString(SharedKey.name);
    final email = await pref.getString(SharedKey.email);
    final phone = await pref.getString(SharedKey.phone);
    final image = await pref.getString(SharedKey.image);

    if (name == null) return null;
    return EditProfileModel(
      fullName: name,
      emailAddress: email ?? "null",
      image: image ?? "null",
      phoneNumber: phone ?? "null",
    );
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
