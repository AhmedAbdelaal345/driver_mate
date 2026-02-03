import 'package:dio/dio.dart';

class ApiResponse {
  ApiResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    this.data,
    this.accessToken,
    this.refreshToken,
  });

  final int statusCode;
  final dynamic data;
  final String? accessToken;
  final String? refreshToken;
  final String message;
  final bool status;

  // Success response
  factory ApiResponse.fromResponse(Response response) {
    final body = response.data;

    return ApiResponse(
      statusCode: response.statusCode ?? 0,
      status: body['status'] ?? false,
      message: body['message'] ?? '',
      data: body['data'] ?? body['user'] , // flexible
      accessToken: body['accessToken'],
      refreshToken: body['refreshToken'],
    );
  }

  // Error response
  factory ApiResponse.fromError(dynamic error) {
    if (error is DioException) {
      final res = error.response;

      return ApiResponse(
        statusCode: res?.statusCode ?? 500,
        status: false,
        message: _handleDioError(error),
        data: res?.data,
      );
    }

    return ApiResponse(
      statusCode: 500,
      status: false,
      message: error.toString(), // important fix
    );
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout with server";
      case DioExceptionType.sendTimeout:
        return "Send timeout in connection with server";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout in connection with server";
      case DioExceptionType.badResponse:
        print("Invalid status code: ${error.response?.statusCode} , message: ${error.response?.data['message'] ?? error.message}");
        return "Invalid status code: ${error.response?.statusCode} , message: ${error.response?.data['message'] ?? error.message}";
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.connectionError:
        return "Internet connection error";
      case DioExceptionType.badCertificate:
        return "Bad certificate";
      case DioExceptionType.unknown:
        return "Unexpected error occurred";
    }
  }
}
