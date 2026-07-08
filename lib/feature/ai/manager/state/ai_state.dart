import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';

abstract class AiChatState {
  final List<ChatRequestModel> messages;

  const AiChatState(this.messages);
}


class AiChatInitial extends AiChatState {
  const AiChatInitial() : super(const []);
}

class AiChatLoading extends AiChatState {
  const AiChatLoading(super.messages);
}

class AiChatUpdated extends AiChatState {
  const AiChatUpdated(super.messages);
}

class AiChatError extends AiChatState {
  final String error;

  const AiChatError(this.error, super.messages);
}
