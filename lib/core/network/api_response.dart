import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_mate/core/local/api_keys.dart';

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

    if (body is Map) {
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        status: body[ApiKeys.status] ?? (response.statusCode == 200 || response.statusCode == 201),
        message: body[ApiKeys.message]?.toString() ?? '',
        data: body[ApiKeys.data] ?? body,
        accessToken: body[ApiKeys.accessToken]?.toString(),
        refreshToken: body[ApiKeys.refreshToken]?.toString(),
      );
    } else {
      return ApiResponse(
        statusCode: response.statusCode ?? 0,
        status: response.statusCode == 200 || response.statusCode == 201,
        message: '',
        data: body,
      );
    }
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
        String serverMessage = error.message ?? '';
        final responseData = error.response?.data;
        if (responseData is Map) {
          serverMessage = responseData['message']?.toString() ?? responseData['error']?.toString() ?? serverMessage;
        } else if (responseData is String && responseData.isNotEmpty) {
          serverMessage = responseData;
        }
        log(
          "Invalid status code: ${error.response?.statusCode} , message: $serverMessage",
        );
        return "Invalid status code: ${error.response?.statusCode} , message: $serverMessage";
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
