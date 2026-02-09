import 'package:dio/dio.dart';
import 'package:driver_mate/core/helper/open_ai_helper.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/ai/data/model/chat_message_model.dart';
import 'package:driver_mate/feature/ai/data/repo/ai_repo.dart';
import 'package:driver_mate/feature/ai/manager/cubit/ai_chat_cubit.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_state.dart';
import 'package:driver_mate/feature/ai/view/widget/ai_bubble_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/input_container_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/quick_action_list.dart';
import 'package:driver_mate/feature/ai/view/widget/user_bubble_widget.dart';

import 'package:driver_mate/feature/mycars/data/repo/vechicle_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';

class AiPage extends StatelessWidget {
  const AiPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return BlocProvider(
      create: (context) =>
          AiChatCubit(AiChatRepo(OpenAiService(Dio())), VechicleRepo()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              title: Text(
                AppConstants.aiAssistant,
                style: AppStyle.titleForContainer.copyWith(fontSize: 18),
              ),
              leading: Icon(Icons.arrow_back_ios, color: AppColors.black),
            ),

            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // ----------------------------------------------------------
                        // 🚗 VEHICLE STATUS CARD
                        // ----------------------------------------------------------
                        Container(
                          decoration: BoxDecorationWidget.customBoxDecoration(),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(10),
                                decoration:
                                    BoxDecorationWidget.customBoxDecoration()
                                        .copyWith(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.veryDarkBlue,
                                              AppColors.cyanColor,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                child: SvgPicture.asset(
                                  AppImagePath.doubleArrowIconPath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.toyotaCamry,
                                      style: AppStyle.titleOfContainer,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: AppColors.green,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Status: Good",
                                          style: AppStyle.containerSubtitle
                                              .copyWith(color: AppColors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                        QuickActionList(),
                        const SizedBox(height: 16),

                        // ----------------------------------------------------------
                        // 🤖 AI Greeting Message
                        // ----------------------------------------------------------
                        BlocBuilder<AiChatCubit, AiChatState>(
                          builder: (context, state) {
                            final cubit = context.read<AiChatCubit>();
                            List<ChatMessageModel> messages = cubit.messages;

                            if (state is AiChatUpdated) {
                              messages = state.messages;
                            } else if (state is AiChatLoading) {
                              // Optional: Show loading indicator or keep showing messages
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: messages.length,

                              itemBuilder: (context, index) {
                                final msg = messages[index];

                                if (msg.type == MessageType.user) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: UserBubbleWidget(text: msg.message),
                                  );
                                } else if (msg.type == MessageType.ai) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AiBubbleWidget(text: msg.message),
                                  );
                                }
                                return const SizedBox.shrink(); // Handle other types or default
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // ----------------------------------------------------------
                // 📝 MESSAGE INPUT BAR
                // ----------------------------------------------------------
                InputContainerWidget(
                  controller: controller,
                  onTap: () {
                    final text = controller.text.trim();

                    if (text.isEmpty) return;

                    context.read<AiChatCubit>().sendMessage(text);

                    controller.clear();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
