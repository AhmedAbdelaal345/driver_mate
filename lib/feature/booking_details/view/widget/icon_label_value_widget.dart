import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/booking_details/view/widget/label_text_widget.dart';
import 'package:flutter/material.dart';

class IconLabelValue extends StatelessWidget {
  const IconLabelValue({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).iconTheme.color),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelText(label: label),
            const SizedBox(height: 2),
            Text(
              value,
              style: AppStyle.titleOfContainer.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
