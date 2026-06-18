import 'dart:io';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/feature/ai/data/model/ai_diagnosis_response_model.dart';
import 'package:driver_mate/feature/ai/data/model/get_diagnosis_history_model.dart';

class AiDiagnosisRepo {
  AiDiagnosisRepo._singelTone();
  static final AiDiagnosisRepo _internal = AiDiagnosisRepo._singelTone();
  factory AiDiagnosisRepo() => _internal;

  // ── Send audio for diagnosis ───────────────────────────────────────────────
  Future<AiDiagnosisResponseModel> sendAudio(File file) async {
    try {
      final response = await ApiHelper().postRequest(
        endpoint: 'diagnostics/analyze',
        isForm: true,
        isAuthorized: true,
        data: {ApiKeys.file: file},
      );
      print("the data from send audio endpoint is ${response.data}");
      return AiDiagnosisResponseModel.fromJson(json: response.data);
    } catch (e) {
      return AiDiagnosisResponseModel.fromJson(
        json: {
          ApiKeys.message: 'Failed to send audio',
          ApiKeys.data: e.toString(),
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

      final List data = response.data[ApiKeys.data] as List;
      return data.map((e) => GetDiagnosisHistoryModel.fromJson(e)).toList();
    } catch (e) {
      print('Failed to get diagnosis history: $e');
      return [];
    }
  }
}
