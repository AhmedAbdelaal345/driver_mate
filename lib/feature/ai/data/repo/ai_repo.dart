import 'package:driver_mate/core/helper/open_ai_helper.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';

class AiChatRepo {
  final OpenAiService service;

  AiChatRepo(this.service);

  Future<String> sendMessage(ChatRequestModel request) async {
    return await service.sendMessage(request);
  }
}
