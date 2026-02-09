import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';

class ChatRequestModel {
  final String message;
  final VechicleModel vehicle;
  final List<ChatMessageModel> history;

  ChatRequestModel({
    required this.message,
    required this.vehicle,
    required this.history,
  });
}
