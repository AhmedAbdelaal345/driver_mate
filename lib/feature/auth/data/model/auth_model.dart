class UserModel {
  final String name;
  final String email;
  final String password;
  bool isAgreed ;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.isAgreed = false,
  });

  // final String token;
  // final String userId;

  // AuthModel({required this.token, required this.userId});

  // factory AuthModel.fromJson(Map<String, dynamic> json) {
  //   return AuthModel(
  //     token: json['token'],
  //     userId: json['userId'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'token': token,
  //     'userId': userId,
  //   };
  // }
}
