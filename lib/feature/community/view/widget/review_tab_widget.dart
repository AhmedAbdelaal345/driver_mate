import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ReviewCard(),
        ReviewCard(),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Auto Care Center"),
          SizedBox(height: 4),
          Text("★★★★★ 5.0"),
          SizedBox(height: 6),
          Text("Excellent service and quick inspection."),
        ],
      ),
    );
  }
}
