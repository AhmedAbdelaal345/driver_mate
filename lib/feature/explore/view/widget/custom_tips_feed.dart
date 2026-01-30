import 'package:driver_mate/feature/explore/view/widget/tips_post_card.dart';
import 'package:flutter/material.dart';

class CustomTipsFeed extends StatelessWidget {
  const CustomTipsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      shrinkWrap: true, // Important since it's inside a SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) =>
          TipPostCard(), // Use the card we discussed earlier
    );
  }
}
