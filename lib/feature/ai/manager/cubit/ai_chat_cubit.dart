import 'package:driver_mate/feature/ai/manager/state/ai_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';
import 'package:driver_mate/feature/ai/data/model/ai_diagnosis_response_model.dart';
import 'package:driver_mate/feature/ai/data/repo/ai_diagnosis_response_repo.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit() : super(const AiChatInitial());

  final AiDiagnosisRepo repo = AiDiagnosisRepo();

  final List<ChatRequestModel> _messages = [];

  Future<void> sendMessage({
    required String message,
    AiDiagnosisResponseModel? diagnosis,
  }) async {
    if (message.trim().isEmpty) return;

    /// Add user's message
    _messages.add(
      ChatRequestModel(
        
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        isUserMessage: true,
        createdAt: DateTime.now().toIso8601String(),
      ),
    );

    emit(AiChatLoading(List.from(_messages)));

    try {
      final aiReply = await repo.askAssistant(
        userQuestion: message,
        diagnosis: diagnosis,
      );

      _messages.add(
        ChatRequestModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: aiReply,
          isUserMessage: false,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

      emit(AiChatUpdated(List.from(_messages)));
    } catch (e) {
      emit(AiChatError(e.toString(), List.from(_messages)));
    }
  }

  void clearConversation() {
    _messages.clear();
    emit(const AiChatInitial());
  }
}