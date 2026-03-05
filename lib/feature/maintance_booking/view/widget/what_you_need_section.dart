import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/cartips/view/widget/custom_chip.dart';

class WhatYouNeedSection extends StatelessWidget {
  const WhatYouNeedSection({super.key,this.item});
  final List<String?>? item;
  @override
  Widget build(BuildContext context) {
    final List<String> items = item == null || item!.isEmpty ? ["Tire gauge", "Air pump", "Owner manual"] : item!.where((e) => e != null).map((e) => e!).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppConstants.whatYouNeed, style: AppStyle.titleOfContainer),
        const SizedBox(height: 12),
    
        Wrap(
          spacing: 10,
          children: items.map((e) => CustomChip(hintText: e)).toList(),
        ),
      ],
    );
  }
}
