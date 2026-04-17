class OtpModel {
  final String email;
  final String otp;
  final String newPassword;

  OtpModel({required this.email, required this.otp,required this.newPassword});

  toMap() {
    return {
      "email": email,
      "code": otp,
      "newPassword": newPassword,
    };
  }
}