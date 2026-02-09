import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';
import 'package:driver_mate/feature/ai/data/repo/ai_repo.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_state.dart';
import 'package:driver_mate/feature/mycars/data/model/vechicle_model.dart';
import 'package:driver_mate/feature/mycars/data/repo/vechicle_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiChatRepo repo;
  final VechicleRepo vechicleRepo;

  AiChatCubit(this.repo, this.vechicleRepo) : super(AiChatInitial());

  final List<ChatMessageModel> messages = [];

  final VechicleModel vehicle = VechicleModel(
    brand: "Toyota",
    model: "Camry",
    year: 2020,
    millAge: 92000,
  );
  Future<VechicleModel?> _getUserVehicle() async {
    final cars = await vechicleRepo.getCar();

    if (cars.isEmpty) return null;

    /// حاليا ناخد آخر عربية
    return cars.last;
  }

  Future<void> sendMessage(String text) async {
    final vehicle = await _getUserVehicle();

    messages.add(
      ChatMessageModel(
        message: text,
        type: MessageType.user,
        time: DateTime.now(),
      ),
    );

    emit(AiChatUpdated(List.from(messages)));

    try {
      emit(AiChatLoading());

      final reply = await repo.sendMessage(
        ChatRequestModel(
          message: text,
          vehicle:
              vehicle ??
              VechicleModel(
                brand: "Unknown",
                model: "Unknown",
                year: 0,
                millAge: 0,
              ),
          history: messages,
        ),
      );

      messages.add(
        ChatMessageModel(
          message: reply,
          type: MessageType.ai,
          time: DateTime.now(),
        ),
      );

      emit(AiChatUpdated(List.from(messages)));
    } catch (e) {
      emit(AiChatError(e.toString()));
    }
  }
}
