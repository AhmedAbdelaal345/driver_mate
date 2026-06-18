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
    final data = json[ApiKeys.data];

    if (data == null) {
      return AiDiagnosisResponseModel(message: json[ApiKeys.message] ?? '');
    }

    final result = data[ApiKeys.result] as Map<String, dynamic>?;

    return AiDiagnosisResponseModel(
      message: json[ApiKeys.message] ?? '',
      audioUrl: data[ApiKeys.audioPath],
      resultMessage: result?[ApiKeys.message],
      severity: result?[ApiKeys.severity],
      confidence: (result?[ApiKeys.confidence] as num?)?.toDouble(),
    );
  }
}
