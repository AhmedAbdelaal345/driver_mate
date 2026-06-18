import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class HighlightsList extends StatelessWidget {
  final List<String> _highlights = const [
    AppConstants.highlight1,
    AppConstants.highlight2,
    AppConstants.highlight3,
    AppConstants.highlight4,
    AppConstants.highlight5,
  ];
const HighlightsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f12,
      ),
      child: Column(
        children: List.generate(_highlights.length, (index) {
          final highlight = _highlights[index];
          final isLast = index == _highlights.length - 1;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.smoothGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 12,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      highlight,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f12,
                        color: AppColors.textGrey,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (!isLast) ...[const SizedBox(height: 14)],
            ],
          );
        }),
      ),
    );
  }
}
