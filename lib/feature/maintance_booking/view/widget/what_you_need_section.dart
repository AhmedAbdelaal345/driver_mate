import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/cartips/view/widget/custom_chip.dart';

class WhatYouNeedSection extends StatelessWidget {
  const WhatYouNeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["Tire gauge", "Air pump", "Owner manual"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("What you need", style: AppStyle.titleOfContainer),
        const SizedBox(height: 12),
    
        Wrap(
          spacing: 10,
          children: items.map((e) => CustomChip(hintText: e)).toList(),
        ),
      ],
    );
  }
}
