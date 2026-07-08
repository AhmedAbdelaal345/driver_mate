import 'package:driver_mate/core/local/api_keys.dart';

class AiDiagnosisResponseModel {
  final String message;
  final String? audioUrl;
  final String? resultMessage;
  final String? severity;
  final double? confidence;

  AiDiagnosisResponseModel({
    required this.message,
    this.audioUrl,
    this.resultMessage,
    this.severity,
    this.confidence,
  });

  factory AiDiagnosisResponseModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    final bool isRoot =
        json.containsKey(ApiKeys.data) && !json.containsKey(ApiKeys.result);
    final rawData = isRoot ? json[ApiKeys.data] : json;
    final message = isRoot ? (json[ApiKeys.message]?.toString() ?? '') : '';

    if (rawData == null) {
      return AiDiagnosisResponseModel(message: message);
    }

    final dataMap = rawData is Map<String, dynamic> ? rawData : null;
    final result = dataMap?[ApiKeys.result] as Map<String, dynamic>?;

    return AiDiagnosisResponseModel(
      message: message,
      audioUrl: dataMap?[ApiKeys.audioPath]?.toString(),
      resultMessage: result?[ApiKeys.message]?.toString(),
      severity: result?[ApiKeys.severity]?.toString(),
      confidence:
          ((result?[ApiKeys.confidence] as num?)?.toDouble()) ?? 0 * 100,
    );
  }
}
