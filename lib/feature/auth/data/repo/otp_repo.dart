import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/auth/data/model/otp_model.dart';

class OTPRepo {
  OTPRepo._singleton();
  static final OTPRepo _instance = OTPRepo._singleton();
  factory OTPRepo() => _instance;

  Future<Either<String, ApiResponse>> postOTPVerify(
    String email,
    String otp,
  ) async {
    ApiHelper apiHelper = ApiHelper();
    try {
      ApiResponse response = await apiHelper.postRequest(
        endpoint: "Auth/verify-otp",
        data: OtpModel(email: email, otp: otp).toMapVerify(),
        isForm: false,
        isAuthorized: false,
      );

      return Right(response);
    } catch (e) {
      print("Error verifying OTP: ${e.toString()}");
      return Left("Error verifying OTP");
    }
  }

  Future<Either<String, ApiResponse>> postOTP(
    String email,
    String otp,
    String newPassword,
  ) async {
    ApiHelper apiHelper = ApiHelper();
    try {
      ApiResponse response = await apiHelper.postRequest(
        endpoint: "auth/reset-password",
        data: OtpModel(
          email: email,
          otp: otp,
          newPassword: newPassword,
        ).toMapReset(),
        isForm: false,
        isAuthorized: false,
      );

      return Right(response);
    } catch (e) {
      print("Error resetting password: ${e.toString()}");
      return Left("Error resetting password");
    }
  }
}
