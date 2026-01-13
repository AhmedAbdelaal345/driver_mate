import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.validator,
  });
  final String hintText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.hintStyle,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.f8),
          borderSide: BorderSide(color: AppConstants.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.f8),
          borderSide: BorderSide(color: AppConstants.grey),
        ),
      ),
    );
  }
}
