import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/ai/view/widget/ai_bubble_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/input_container_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/quick_action_list.dart';
import 'package:driver_mate/feature/ai/view/widget/user_bubble_widget.dart';
import 'package:driver_mate/feature/ai/view/widget/voice_bubble_widget.dart';
import 'package:flutter/material.dart';
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
                          decoration: BoxDecorationWidget.customBoxDecoration()
                              .copyWith(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.veryDarkBlue,
                                    AppColors.cyanColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(18),
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
                                    style: AppStyle.containerSubtitle.copyWith(
                                      color: AppColors.green,
                                    ),
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
                  AiBubbleWidget(
                    text:
                        "Hello! I'm your AI assistant. I can help you diagnose car sounds, "
                        "find maintenance centers, schedule services, or assist in emergencies.",
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // 👤 User Message
                  // ----------------------------------------------------------
                  UserBubbleWidget(
                    text:
                        "My car is making a strange noise when I brake. What could it be?",
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // 🤖 AI Response + CTA Button
                  // ----------------------------------------------------------
                  AiBubbleWidget(
                    text:
                        "A strange noise when braking could indicate worn brake pads, "
                        "warped rotors, or loose components. I recommend getting this checked soon.",
                    action: "Find nearby mechanics",
                  ),

                  const SizedBox(height: 12),

                  // ----------------------------------------------------------
                  // 🎤 Voice Bubble
                  // ----------------------------------------------------------
                  VoiceBubbleWidget(),
                ],
              ),
            ),
          ),

          // ----------------------------------------------------------
          // 📝 MESSAGE INPUT BAR
          // ----------------------------------------------------------
          InputContainerWidget(controller: controller, onTap: () {}),
        ],
      ),
    );
  }
}
