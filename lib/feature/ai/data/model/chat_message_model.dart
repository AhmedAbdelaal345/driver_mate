enum MessageType { user, ai, voice }

class ChatMessageModel {
  final String message;
  final MessageType type;
  final DateTime time;
  final String? intent;

  ChatMessageModel({
    required this.message,
    required this.type,
    required this.time,
    this.intent,
  });
}
