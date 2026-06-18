import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(context,
        borderRadius: AppFontSize.f12,
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: AppConstants.additionalNotesHint,
          hintStyle: AppStyle.hintStyle.copyWith(fontSize: AppFontSize.f11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f12),
            borderSide: BorderSide(color: AppColors.containerGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f12),
            borderSide: BorderSide(color: AppColors.containerGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f12),
            borderSide: BorderSide(color: AppColors.cyanColor),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f12,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
