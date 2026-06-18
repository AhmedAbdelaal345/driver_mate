class OtpModel {
  final String email;
  final String otp;
  String? newPassword;
  OtpModel({required this.email, required this.otp, this.newPassword});

  toMapVerify() {
    return {"email": email, "code": otp};
  }
  toMapReset() {
    return {"email": email, "code": otp, "newPassword": newPassword};
  }
}
