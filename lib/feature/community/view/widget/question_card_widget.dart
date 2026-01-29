import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(child: Text("AH")),
              const SizedBox(width: 8),
              const Text("Ahmed Hassan"),
              const Spacer(),
              Chip(label: Text("Question")),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Strange clicking sound when turning — what could it be?",
            style: AppStyle.titleOfContainer,
          ),
          const SizedBox(height: 6),
          Text(
            "My car makes a clicking noise when I turn the steering wheel...",
            style: AppStyle.containerSubtitle,
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.favorite_border, size: 18),
              SizedBox(width: 4),
              Text("12"),
              SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 18),
              SizedBox(width: 4),
              Text("8"),
            ],
          ),
        ],
      ),
    );
  }
}
