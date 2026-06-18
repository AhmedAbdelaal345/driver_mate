import 'package:driver_mate/core/helper/app_notifier.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/feature/ai/data/model/chat_request_model.dart';
import 'package:driver_mate/feature/ai/manager/cubit/ai_chat_cubit.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_state.dart';
import 'package:driver_mate/feature/ai/view/widget/ai_bubble_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/input_container_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/user_bubble_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/vehicle_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  // WHY removed the orphaned `cubit` field:
  // initState created AiChatCubit()..fetchHistory() AND BlocProvider.create
  // also created AiChatCubit()..fetchHistory() — two cubits, two network
  // calls, one memory leak (the initState cubit was never closed).
  // BlocProvider owns the single cubit now; nothing else needed in initState.

  late final TextEditingController _controller;

  // WHY ScrollController:
  // Without it the list never auto-scrolls when a new message is added.
  // The user has to manually scroll down to see every AI reply.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiChatCubit()..fetchHistory(),
      // WHY removed the Builder wrapper:
      // Builder was needed in the original because context.read<AiChatCubit>()
      // was called inside the same build() that owns the BlocProvider — you
      // cannot read a provider from the context that created it.
      // Now that all reads happen inside BlocConsumer/BlocBuilder (which each
      // receive their own child context), the extra Builder layer is gone.
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: Text(
            AppStrings.of(context).aiAssistant,
            style: AppStyle.titleForContainer.copyWith(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<AiChatCubit, AiChatState>(
                
                listenWhen: (_, current) =>
                    current is AiChatUpdated || current is AiChatError,
                listener: (context, state) {
                  if (state is AiChatUpdated) {
                    _scrollToBottom();
                  } else if (state is AiChatError) {
                    // WHY SnackBar in listener:
                    // Original code had NO AiChatError handling — errors were
                    // silently swallowed.  Users never knew why messages failed.
                    AppNotifier.show(
                      context,
                      state.message,
                      type: NotifierType.error,
                    );
                  }
                },
                builder: (context, state) {
                  // WHY derive messages from state, not from cubit directly:
                  // Original code:
                  //   final cubit = context.read<AiChatCubit>();
                  //   List<ChatRequestModel> messages = cubit.messages;
                  //   if (state is AiChatUpdated) messages = state.messages;
                  //
                  // Reading cubit.messages directly bypasses reactivity.
                  // If the cubit mutates the list without emitting a new state,
                  // the widget never rebuilds.  Always derive UI data from the
                  // emitted state.
                  //
                  // WHY fall back to cubit.messages for non-Updated states:
                  // During AiChatLoading (typing indicator), we still need to
                  // show the previously visible messages.  cubit.messages holds
                  // the last known list and is safe to read here as a fallback.
                  final List<ChatRequestModel> messages = switch (state) {
                    AiChatUpdated() => state.messages,
                    _ => context.read<AiChatCubit>().messages,
                  };

                  // WHY two separate booleans instead of one isLoading:
                  // isInitialLoading: list is empty + loading → show a
                  //   full-page spinner (nothing to render yet).
                  // isTyping: list has messages + loading → show the chat
                  //   normally with a "..." bubble at the end.
                  //
                  // Original code showed a CircularProgressIndicator that
                  // REPLACED all messages — the entire chat disappeared while
                  // waiting for each AI reply.
                  final bool isInitialLoading =
                      state is AiChatLoading && messages.isEmpty;
                  final bool isTyping =
                      state is AiChatLoading && messages.isNotEmpty;

                  return ListView(
                    controller: _scrollController,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // ── VEHICLE STATUS CARD (unchanged) ───────────
                          VehicleStatusCard(),

                          // ── INITIAL LOADING ───────────────────────────
                          if (isInitialLoading)
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            )
                          // ── GREETING (no messages yet) ─────────────────
                          else if (messages.isEmpty)
                            AiBubbleWidget(
                              text:
                                  "Hello! I'm your AI assistant. How can I help you today?",
                            )
                          // ── MESSAGE LIST ───────────────────────────────
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // WHY itemCount + 1 when isTyping:
                              // The extra slot renders the "..." bubble while
                              // the API call is in flight.  It disappears the
                              // moment AiChatUpdated is emitted with the real
                              // AI reply — no extra state or widget needed.
                              itemCount: messages.length + (isTyping ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (isTyping && index == messages.length) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AiBubbleWidget(text: '...'),
                                  );
                                }

                                final msg = messages[index];
                                if (msg.isUserMessage == true) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: UserBubbleWidget(text: msg.message),
                                  );
                                } else if (msg.isUserMessage == false) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AiBubbleWidget(text: msg.message),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

            // ── MESSAGE INPUT BAR ──────────────────────────────────────────
            // WHY BlocBuilder wraps InputContainerWidget:
            // The send button must be disabled while AiChatLoading is active
            // to prevent the user from queueing multiple requests.
            // Original code had no such guard — rapid taps sent multiple calls.
            BlocBuilder<AiChatCubit, AiChatState>(
              buildWhen: (previous, current) =>
                  (previous is AiChatLoading) != (current is AiChatLoading),
              builder: (context, state) {
                final bool isBusy = state is AiChatLoading;
                return InputContainerWidget(
                  controller: _controller,
                  onTapMessage: isBusy
                      ? null
                      : () {
                          final text = _controller.text.trim();
                          if (text.isEmpty) return;
                          context.read<AiChatCubit>().sendMessage(text);
                          _controller.clear();
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
