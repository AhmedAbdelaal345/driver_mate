import "package:dio/dio.dart";
import "package:driver_mate/core/network/api_constants.dart";
import "package:driver_mate/feature/ai/data/model/gemenai_request_model.dart";
import "package:driver_mate/feature/ai/data/model/gemenai_response_model.dart";

class GeminiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.geminiBaseUrl,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
    ),
  );

  Future<GeminiResponseModel> generate(GeminiRequestModel request) async {
    final response = await dio.post(
      "models/gemini-2.5-flash:generateContent?key=${ApiConstants.geminiApiKey}",
      
      data: request.toJson(),
    );

    return GeminiResponseModel.fromJson(response.data);
  }
}
