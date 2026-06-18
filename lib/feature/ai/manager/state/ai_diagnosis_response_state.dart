import 'package:driver_mate/feature/ai/data/model/ai_diagnosis_response_model.dart';

abstract class AiDiagnosisState {}

class AiDiagnosisInitial extends AiDiagnosisState {}

class AiDiagnosisLoading extends AiDiagnosisState {}

class AiDiagnosisSuccess extends AiDiagnosisState {
  final AiDiagnosisResponseModel result;
  AiDiagnosisSuccess(this.result);
}

class AiDiagnosisError extends AiDiagnosisState {
  final String message;
  AiDiagnosisError(this.message);
}


