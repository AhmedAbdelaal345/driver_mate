class ForgetPasswordModel {
  final String email;
  static const String purpose = "ResetPassword";
  const ForgetPasswordModel({required this.email});
  toMap() {
    return {"email": email, "purpose": purpose};
  }
}
