class ChatRequestModel {
  final String id;
  final String message;
  final bool? isUserMessage;
  final String? createdAt;

  ChatRequestModel({
    required this.id,
    required this.message,
    this.isUserMessage,
    this.createdAt,
  });


  factory ChatRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      id: json['id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      isUserMessage: json['isUserMessage'] as bool?,
      createdAt: json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isUserMessage': isUserMessage,
      'createdAt': createdAt,
    };
  }
}
