import 'dart:developer' as consol;

import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/core/network/api_constants.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/auth/data/model/auth_model.dart';

class AuthRepo {
  UserModel? user;
  // here we make singleton pattern to avoid multiple instances of AuthRepo class
  AuthRepo._singleToneConstructor();
  static final AuthRepo instance = AuthRepo._singleToneConstructor();
  factory AuthRepo() {
    // called by reference
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> register({required UserModel user}) async {
    try {
      this.user = user;
      ApiResponse response = await apiHelper.postRequest(
        endpoint: ApiConstants.registerEndpoint,
        isForm: false,
        data: {
          ApiKeys.fullname: user.name,
          ApiKeys.email: user.email,
          ApiKeys.password: user.password,
          ApiKeys.confirmPassword: user.password,
          // ApiKeys.isAgreed: true,
        },
        isAuthorized: false,
      );
      if (response.status == true) {
        consol.log(response.message);
        return Right(response.message);
      } else {
        consol.log(response.message);

        return Left(response.message);
      }
    } on Exception catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<ApiResponse, ApiResponse>> login({
  required String email,
  required String password,
}) async {
  try {
    final response = await apiHelper.postRequest(
      isAuthorized: false,
      endpoint: ApiConstants.loginEndpoint,
      isForm: false,
      data: {
        ApiKeys.email: email,
        ApiKeys.password: password,
      },
    );

    if (response.status == true) {
      if (response.accessToken != null) {
        ApiConstants.accessToken = response.accessToken!;
      }

      if (response.refreshToken != null) {
        ApiConstants.refreshToken = response.refreshToken!;
      }

      return Right(response);
    } else {
      return Left(response);
    }
  } catch (e) {
    return Left(ApiResponse.fromError(e));
  }
}
}
