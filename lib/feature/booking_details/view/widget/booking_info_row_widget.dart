import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class BookingInfoRow extends StatelessWidget {
  const BookingInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.containerSubtitle.copyWith(
            color: Theme.of(context).iconTheme.color,
          ),
        ),

        Flexible(
          child: Text(
            value,
            style: AppStyle.titleOfContainer.copyWith(
              color: valueColor ?? Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
