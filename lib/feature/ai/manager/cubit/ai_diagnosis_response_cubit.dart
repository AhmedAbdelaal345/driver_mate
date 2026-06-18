import 'dart:io';

import 'package:driver_mate/feature/ai/data/repo/ai_diagnosis_response_repo.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_diagnosis_response_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiDiagnosisCubit extends Cubit<AiDiagnosisState> {
  AiDiagnosisCubit() : super(AiDiagnosisInitial());
  final AiDiagnosisRepo repo = AiDiagnosisRepo();
  Future<void> sendAudio({required File file}) async {
    try {
      emit(AiDiagnosisLoading());
      final result = await repo.sendAudio(file);
      emit(AiDiagnosisSuccess(result));
    } catch (e) {
      emit(AiDiagnosisError(e.toString()));
    }
  }
  
}
//   final AiDiagnosisRepo repo;

//   AiDiagnosisCubit(this.repo) : super(AiInitial());

//   Future<void> sendAudio(String path) async {
//     emit(AiLoading());

//     try {
//       final result = await repo.sendAudio(File(path));
//       emit(AiSuccess(result));
//     } catch (e) {
//       emit(AiError(e.toString()));
//     }
//   }
// }
