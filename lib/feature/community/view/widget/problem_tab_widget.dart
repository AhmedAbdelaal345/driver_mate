import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ProblemsTab extends StatelessWidget {
  const ProblemsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProblemCard(),
        ProblemCard(),
      ],
    );
  }
}

class ProblemCard extends StatelessWidget {
  const ProblemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AC not cooling properly", style: AppStyle.titleOfContainer),
          const SizedBox(height: 6),
          Text("AC blows air but not cold.", style: AppStyle.containerSubtitle),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.smart_toy),
            label: const Text("Get AI Help"),
          ),
        ],
      ),
    );
  }
}
