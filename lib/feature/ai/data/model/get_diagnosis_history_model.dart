import 'package:driver_mate/core/local/api_keys.dart';

class DiagnosisResultModel {
  final String message;
  final String severity;
  final double confidence;

  DiagnosisResultModel({
    required this.message,
    required this.severity,
    required this.confidence,
  });

  factory DiagnosisResultModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DiagnosisResultModel(
      message: json[ApiKeys.message] ?? '',
      severity: json[ApiKeys.severity] ?? '',
      confidence:
          (json[ApiKeys.confidence] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.message: message,
      ApiKeys.severity: severity,
      ApiKeys.confidence: confidence,
    };
  }
}


class GetDiagnosisHistoryModel {
  final String id;
  final String audioPath;
  final DiagnosisResultModel result;
  final DateTime createdAt;

  GetDiagnosisHistoryModel({
    required this.id,
    required this.audioPath,
    required this.result,
    required this.createdAt,
  });

  factory GetDiagnosisHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetDiagnosisHistoryModel(
      id: json[ApiKeys.id] ?? '',
      audioPath: json[ApiKeys.audioPath] ?? '',
      result: DiagnosisResultModel.fromJson(
        json[ApiKeys.result],
      ),
      createdAt: DateTime.parse(
        json[ApiKeys.createdAt],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.id: id,
      ApiKeys.audioPath: audioPath,
      ApiKeys.result: result.toJson(),
      ApiKeys.createdAt: createdAt.toIso8601String(),
    };
  }
}