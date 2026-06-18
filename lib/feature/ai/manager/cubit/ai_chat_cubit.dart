import 'package:dartz/dartz.dart';
import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';
import 'package:driver_mate/feature/ai/data/repo/ai_repo.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit() : super(AiChatInitial());

  // WHY keep messages as a local list:
  // The list acts as an in-memory cache so that when the cubit emits
  // AiChatLoading (between user message and AI reply), the page can still
  // fall back to cubit.messages and render previously visible messages
  // instead of a blank screen.  The list must be kept in sync with every
  // emit — see WHY List.from below.
  final List<ChatRequestModel> messages = [];
  final AiChatRepo repo = AiChatRepo();

  Future<void> sendMessage(String text) async {
    try {
      // ── Step 1: Add user message and show it immediately ─────────────
      messages.add(
        ChatRequestModel(
          id: DateTime.now().toString(),
          message: text,
          isUserMessage: true,
          createdAt: DateTime.now().toString(),
        ),
      );
      // WHY List.from (immutable snapshot):
      // Emitting `messages` directly shares the same List reference with the
      // state.  When the next mutation happens (messages.add), the previously
      // emitted state's list mutates too — BlocBuilder compares references and
      // sees no change, so it may not rebuild.  List.from creates a new list
      // object so each emitted state is an independent snapshot.
      emit(AiChatUpdated(List.from(messages)));

      // ── Step 2: Emit loading so the page can show a typing indicator ──
      // WHY emit AiChatLoading here (not in original code):
      // The original sendMessage went directly from AiChatUpdated (user msg)
      // to AiChatUpdated (AI reply) with no intermediate state.  The page had
      // no signal that the AI was "thinking", so it couldn't show a typing
      // bubble.  Emitting AiChatLoading between the two AiChatUpdated emits
      // gives the page exactly that signal.
      //
      // The page's isTyping flag:
      //   final bool isTyping = state is AiChatLoading && messages.isNotEmpty;
      // reads cubit.messages (which still has the user's message) while
      // showing the "..." bubble — so the chat list stays visible during
      // the wait.
      emit(AiChatLoading());

      // ── Step 3: Await AI response ─────────────────────────────────────
      final Either<String, ChatRequestModel> response = await repo.sendMessage(
        ChatMessageModel(message: text),
      );

      response.fold(
        (error) {
          // On error, emit error state.  The page will show a SnackBar.
          // cubit.messages already has the user message, so if the user
          // retries, history is preserved locally.
          emit(AiChatError(error));

          // Re-emit the current messages so the chat list is restored after
          // the error state — without this the page stays on AiChatError
          // and the builder falls back to cubit.messages correctly, but
          // emitting Updated is cleaner and explicit.
          emit(AiChatUpdated(List.from(messages)));
        },
        (aiMessage) {
          // ── Step 4: Add AI reply and update UI ────────────────────────
          messages.add(aiMessage);
          emit(AiChatUpdated(List.from(messages)));
        },
      );
    } catch (e) {
      emit(AiChatError('Failed to send message: ${e.toString()}'));
      print(e.toString());
      // Restore chat after unexpected exception
      emit(AiChatUpdated(List.from(messages)));
    }
  }

  Future<void> fetchHistory() async {
    emit(AiChatLoading());

    try {
      final Either<String, List<ChatRequestModel>> response = await repo
          .getHistory();

      response.fold((error) => emit(AiChatError(error)), (history) {
        messages.clear();
        messages.addAll(history);
        // WHY List.from here too:
        // Same reason as sendMessage — emit an immutable snapshot so
        // future mutations to `messages` don't silently mutate this state.
        emit(AiChatUpdated(List.from(messages)));
      });
    } catch (e) {
      emit(AiChatError('Failed to fetch history: ${e.toString()}'));
      print(e.toString());
    }
  }
}
