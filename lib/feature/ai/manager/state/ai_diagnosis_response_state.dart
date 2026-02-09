abstract class AiDiagnosisState {}

class AiInitial extends AiDiagnosisState {}

class AiLoading extends AiDiagnosisState {}

class AiSuccess extends AiDiagnosisState {
  final String result;
  AiSuccess(this.result);
}

class AiError extends AiDiagnosisState {
  final String message;
  AiError(this.message);
}
