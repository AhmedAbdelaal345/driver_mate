// enum MessageType { user, ai, voice }

class ChatMessageModel {
  final String message;

  ChatMessageModel({required this.message});
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(message: json['data']["aiResponse"]);
  }
  Map<String, dynamic> toMap() => {'message': message};
}
