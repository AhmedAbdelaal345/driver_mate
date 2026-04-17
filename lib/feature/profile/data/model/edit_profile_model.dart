import 'package:driver_mate/core/local/api_keys.dart';

class EditProfileModel {
  final String fullName;
  final String phoneNumber;
  final String emailAddress;
  final String image;
  final String accessToken;
  EditProfileModel({
    required this.fullName,
    required this.emailAddress,
    required this.image,
    required this.phoneNumber,
    required this.accessToken,
  });
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      fullName: json[ApiKeys.fullname],
      emailAddress: json[ApiKeys.email],
      image: json[ApiKeys.image],
      phoneNumber: json[ApiKeys.phone],
      accessToken: json[ApiKeys.accessToken],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ApiKeys.fullname: fullName,
      ApiKeys.email: emailAddress,
      ApiKeys.image: image,
      ApiKeys.phone: phoneNumber,
      ApiKeys.accessToken: accessToken,
    };
  }
}
