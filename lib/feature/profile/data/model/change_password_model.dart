class ChangePasswordModel {
  String oldPassword;
  String newPassword;

  ChangePasswordModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}