import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/cartips/view/widget/custom_chip.dart';
import 'package:flutter/material.dart';

class TipItem extends StatelessWidget {
  const TipItem({
    super.key,
    required this.title,
    required this.tag,
    required this.time,
  });
  final String title;
  final String tag;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
      ).copyWith(borderRadius: BorderRadius.circular(12)),

      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CustomChip(hintText: tag),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}
