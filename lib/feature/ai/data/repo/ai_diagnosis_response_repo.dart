import 'dart:io';
import 'package:driver_mate/core/helper/open_ai_helper.dart';

class AiDiagnosisRepo {
  AiDiagnosisRepo(this.service);
  final OpenAiService service;

  Future<String> sendAudio(File file) async {
    /// 1) convert speech to text
    final text = await service.speechToText(file);

    /// 2) send text to GPT
    final diagnosis = await service.diagnoseFromText(text);

    return diagnosis;
  }
}
