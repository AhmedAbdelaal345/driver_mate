import 'package:driver_mate/feature/ai/data/model/get_diagnosis_history_model.dart';

abstract class GetDiagnosisHistoryState {}

class GetDiagnosisHistoryInitial extends GetDiagnosisHistoryState {}

class GetDiagnosisHistoryLoading extends GetDiagnosisHistoryState {}

class GetDiagnosisHistorySuccess extends GetDiagnosisHistoryState {
  final List<GetDiagnosisHistoryModel> items;
  final bool hasMore;
  final bool isLoadingMore;

  GetDiagnosisHistorySuccess({
    required this.items,
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class GetDiagnosisHistoryError extends GetDiagnosisHistoryState {
  final String message;
  GetDiagnosisHistoryError(this.message);
}
