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
          ApiKeys.name: user.name,
          ApiKeys.email: user.email,
          ApiKeys.password: user.password,
          ApiKeys.isAgreed: true,
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

  Future<Either<ApiResponse, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (user == null) {
        return Left(
          ApiResponse(
            statusCode: 500,
            status: false,
            message: "User not found",
          ),
        );
      }

      if (email != user!.email || password != user!.password) {
        return Left(
          ApiResponse(
            statusCode: 500,
            status: false,
            message: "Wrong email or password",
          ),
        );
      }

      ApiResponse response = await apiHelper.postRequest(
        isAuthorized: false,
        endpoint: ApiConstants.loginEndpoint,
        data: {ApiKeys.email: email, ApiKeys.password: password},
      );

      if (response.accessToken != null && response.refreshToken != null) {
        ApiConstants.accessToken = response.accessToken!;
        ApiConstants.refreshToken = response.refreshToken!;
      }

      return Right(
        LoginResponse(
          status: response.status,
          message: response.message,
          accessToken: ApiConstants.accessToken,
          refreshToken: ApiConstants.refreshToken,
          user: user!,
        ),
      );
    } catch (e) {
      return Left(ApiResponse.fromError(e));
    }
  }
}
