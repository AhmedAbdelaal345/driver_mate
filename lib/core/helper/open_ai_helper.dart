import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';

class OpenAiService {
  final Dio dio;
  OpenAiService(this.dio);
  final String apiKey =
      "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";
  Future<String> speechToText(File file) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "model": "gpt-4o-mini-transcribe",
    });

    final response = await dio.post(
      "https://api.openai.com/v1/audio/transcriptions",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $apiKey"}),
    );

    return response.data['text'];
  }

  Future<String> diagnoseFromText(String text) async {
    final response = await dio.post(
      "https://api.openai.com/v1/chat/completions",
      data: {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
                "You are an expert car diagnostic AI. Return mechanical issue and possible solution.",
          },
          {"role": "user", "content": text},
        ],
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      ),
    );

    return response.data[ApiKeys.choices][0][ApiKeys.message][ApiKeys.content];
  }

  Future<String> sendMessage(ChatRequestModel request) async {
    final vehicle = request.vehicle;

    final response = await dio.post(
      "https://api.openai.com/v1/chat/completions",
      data: {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content":
                """
You are an automotive AI assistant inside DriverMate app.

Vehicle Information:
Brand: ${vehicle.brand ?? "unknown"}
Model: ${vehicle.model ?? "unknown"}
Year: ${vehicle.year ?? "unknown"}
Mileage: ${vehicle.millAge ?? "unknown"}

Your tasks:
- Diagnose car problems
- Suggest maintenance
- Detect emergency situations
- Recommend service actions
""",
          },
          ...request.history.map(
            (m) => {
              "role": m.type == MessageType.user ? "user" : "assistant",
              "content": m.message,
            },
          ),
          {"role": "user", "content": request.message},
        ],
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
      ),
    );

    return response.data['choices'][0]['message']['content'];
  }
}
