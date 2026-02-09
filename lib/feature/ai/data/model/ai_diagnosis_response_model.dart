import 'package:driver_mate/core/local/api_keys.dart';

class AiDiagnosisResponseModel {
  final String message;

  AiDiagnosisResponseModel({required this.message});
  factory AiDiagnosisResponseModel.fromJson(Map<String, dynamic> json) {
    return AiDiagnosisResponseModel(
      message: json[ApiKeys.choices][0][ApiKeys.message][ApiKeys.content],
    );
  }
}
