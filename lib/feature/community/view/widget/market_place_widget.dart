import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class MarketplaceTab extends StatelessWidget {
  const MarketplaceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        MarketplaceCard(),
      ],
    );
  }
}

class MarketplaceCard extends StatelessWidget {
  const MarketplaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Brake Pads for Toyota Camry",
              style: AppStyle.titleOfContainer),
          const SizedBox(height: 6),
          Text("\$45 · New Cairo", style: AppStyle.containerSubtitle),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text("View Details"),
          ),
        ],
      ),
    );
  }
}
