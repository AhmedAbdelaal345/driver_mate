import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        
        controller: controller,
        validator: (value) {
          if (value == null) {
            return AppConstants.youMust;
          }
          return null;
        },
        cursorColor: AppColors.cyanColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.boarderWhiteColor),
            borderRadius: BorderRadius.circular(25),
          ),
          fillColor: AppColors.white,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.cyanColor),
            borderRadius: BorderRadius.circular(25),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.boarderWhiteColor),
            borderRadius: BorderRadius.circular(25),
          ),
          hint: Text(
            AppConstants.askQuestion,
            style: TextStyle(
              color: AppColors.midGrey,
              fontSize: AppFontSize.f14,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
