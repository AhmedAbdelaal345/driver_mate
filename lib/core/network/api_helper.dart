import 'package:dio/dio.dart';
import 'package:driver_mate/core/network/api_constants.dart';
import 'package:driver_mate/core/network/api_response.dart';

class ApiHelper {
  ApiHelper._internal();
  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static final ApiHelper instance = ApiHelper._internal();
  factory ApiHelper() {
    return instance;
  }

  Future<ApiResponse> postRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    bool isAuthorized = true,
    bool isForm = true,
  }) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: isForm ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              ApiConstants.authorization: "Bearer${ApiConstants.accessToken}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> getRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    bool isForm = true,
    bool isAuthorized = true,
  }) async {
    try {
      Response response = await dio.get(
        endpoint,
        data: isForm ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              ApiConstants.authorization: "Bearer${ApiConstants.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    bool isForm = true,
    bool isAuthorized = true,
  }) async {
    try {
      Response response = await dio.put(
        endpoint,
        data: isForm ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              ApiConstants.authorization: "Bearer${ApiConstants.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    bool isForm = true,
    bool isAuthorized = true,
  }) async {
    try {
      Response response = await dio.delete(
        endpoint,
        data: isForm ? FormData.fromMap(data ?? {}) : data,
        options: Options(
          headers: {
            if (isAuthorized)
              ApiConstants.authorization: "Bearer${ApiConstants.accessToken}",
          },
        ),
      );
      return ApiResponse.fromResponse(response);
    } on Exception catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
