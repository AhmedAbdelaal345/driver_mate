import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:driver_mate/feature/explore/view/widget/tips_post_card.dart';
import 'package:flutter/material.dart';

class CustomTipsFeed extends StatelessWidget {
  const CustomTipsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockTips.length,
      itemBuilder: (context, index) => TipPostCard(item: mockTips[index]),
    );
  }
}
