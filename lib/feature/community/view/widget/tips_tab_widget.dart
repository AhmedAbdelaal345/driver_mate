import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [TipCard(), TipCard()]);
  }
}

class TipCard extends StatelessWidget {
  const TipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Best oil change interval for city driving",
            style: AppStyle.titleOfContainer,
          ),
          const SizedBox(height: 6),
          Text(
            "I recommend changing oil every 5,000 km.",
            style: AppStyle.containerSubtitle,
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.bookmark_border),
              SizedBox(width: 6),
              Text("156 saved"),
            ],
          ),
        ],
      ),
    );
  }
}
