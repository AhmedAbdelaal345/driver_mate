class LoginResponse {
  final bool status;
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}

class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? password;
  UserModel({this.id, required this.name, required this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }
}

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

