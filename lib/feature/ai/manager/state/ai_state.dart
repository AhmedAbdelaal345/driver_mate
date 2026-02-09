import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';

abstract class AiChatState {}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {}

class AiChatUpdated extends AiChatState {
  final List<ChatMessageModel> messages;

  AiChatUpdated(this.messages);
}

class AiChatError extends AiChatState {
  final String message;
  AiChatError(this.message);
}
