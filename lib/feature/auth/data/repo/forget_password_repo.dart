import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/auth/data/model/forget_password_model.dart';

class ForgetPasswordRepo {
  ForgetPasswordRepo._singleton();
  static final ForgetPasswordRepo _instance = ForgetPasswordRepo._singleton();
  factory ForgetPasswordRepo() => _instance;
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, ApiResponse>> sendEmail(String email) async {
    // Implement your logic to send the email for password reset
    // You can use an API call or any other method to send the email

    try {
      ApiResponse response = await apiHelper.postRequest(
        endpoint: "/auth/request-otp",
        isForm: false,
        data: ForgetPasswordModel(email: email).toMap(),
      );
      if(response.status == 200){
        return Right(response);
      }else{
        return Left(response.message);
      }
    } on Exception catch (e) {
      print("Error sending email: ${e.toString()}");
      return Left("An error occurred while sending the email: ${e.toString()}");
    }
  }
}
