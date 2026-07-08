import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: 16,
      ).copyWith(color: Theme.of(context).cardColor),
      child: child,
    );
  }
}
