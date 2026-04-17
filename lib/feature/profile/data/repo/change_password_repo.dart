import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/profile/data/model/change_password_model.dart';

class ChangePasswordRepo {
  ChangePasswordRepo._singleton();
  static final ChangePasswordRepo _instance = ChangePasswordRepo._singleton();
  factory ChangePasswordRepo() {
    return _instance;
  }
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, ApiResponse>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endpoint: 'auth/change-password',
        isForm: false,
        isAuthorized: true,
        data: ChangePasswordModel(
          oldPassword: oldPassword,
          newPassword: newPassword,
        ).toJson(),
      );
      return Right(response);
    } catch (e) {
      return Left('Failed to change password: $e');
    }
  }
}
