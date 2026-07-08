import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/service/ai_chat_service.dart';
import 'package:driver_mate/feature/ai/data/model/ai_diagnosis_response_model.dart';
import 'package:driver_mate/feature/ai/data/model/gemenai_request_model.dart';
import 'package:driver_mate/feature/ai/data/model/get_diagnosis_history_model.dart';

class AiDiagnosisRepo {
  AiDiagnosisRepo._singelTone();
  static final AiDiagnosisRepo _internal = AiDiagnosisRepo._singelTone();
  factory AiDiagnosisRepo() => _internal;
  final GeminiService _geminiService = GeminiService();

  // ── Send audio for diagnosis ───────────────────────────────────────────────
  Future<AiDiagnosisResponseModel> sendAudio(File file) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );
      final response = await ApiHelper().postRequest(
        endpoint: 'diagnostics/analyze',
        isForm: true,
        isAuthorized: true,
        data: {ApiKeys.file: multipartFile},
      );
      // response.data is already the unpacked "data" object from ApiResponse.
      // Wrap it back so AiDiagnosisResponseModel.fromJson can locate 'result'.
      return AiDiagnosisResponseModel.fromJson(
        json: {
          ApiKeys.message: response.message,
          ApiKeys.data: response.data,
        },
      );
    } catch (e) {
      return AiDiagnosisResponseModel.fromJson(
        json: {
          ApiKeys.message: 'Failed to send audio: ${e.toString()}',
          ApiKeys.data: null,
        },
      );
    }
  }

  // ── Paginated history ─────────────────────────────────────────────────────
  Future<List<GetDiagnosisHistoryModel>> getDiagnosisHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await ApiHelper().getRequest(
        endpoint: 'diagnostics/history',
        isAuthorized: true,

        // pass pagination as query params — adjust to your ApiHelper signature
        queryParameters: {'page': page, 'limit': limit},
      );

      final rawData = response.data;
      final List data = rawData is List ? rawData : (rawData[ApiKeys.data] as List? ?? []);
      return data.map((e) => GetDiagnosisHistoryModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Failed to get diagnosis history: $e');
      return [];
    }
  }

  Future<String> askAssistant({
    required String userQuestion,
    AiDiagnosisResponseModel? diagnosis,
  }) async {
    try {
      final prompt = _buildPrompt(
        userQuestion: userQuestion,
        diagnosis: diagnosis,
      );

      final response = await _geminiService.generate(
        GeminiRequestModel(prompt: prompt),
      );

      return response.text;
    } catch (e) {
      throw Exception("Failed to communicate with Gemini: $e");
    }
  }

  String _buildPrompt({
    required String userQuestion,
    AiDiagnosisResponseModel? diagnosis,
  }) {
    final buffer = StringBuffer();

    buffer.writeln("""
You are Driver Mate AI.

You are an automotive assistant.

Only answer questions related to:

- Cars
- Maintenance
- Engine diagnostics
- Vehicle safety
- Repairs

If the user asks anything unrelated,
politely refuse.
""");

    if (diagnosis != null) {
      buffer.writeln("""

Current diagnosis:

Problem:
${diagnosis.resultMessage}

Severity:
${diagnosis.severity}

Confidence:
${((diagnosis.confidence ?? 0) * 100).toStringAsFixed(0)}%

""");
    }

    buffer.writeln("""

User question:

$userQuestion

Answer professionally.
""");

    return buffer.toString();
  }
}
