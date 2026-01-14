import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckTextfieldWidget extends StatelessWidget {
  const CheckTextfieldWidget({
    super.key,
    required this.validator,
    required this.controller,
    this.onChanged, // Optional: if you want to pass extra logic from parent
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.068 * SizeConfig.width(context),
      height: 0.13 * SizeConfig.height(context), // Fixed typo: 013 -> 0.13
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLength: 1,
        textAlign: TextAlign.center, // Centers the number inside the box
        
        // --- KEY CHANGE HERE ---
        onChanged: (value) {
          // 1. Move to next field if length is 1
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          // 2. Execute any additional logic passed from parent
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        // -----------------------

        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Ensures only numbers
        ],
        decoration: InputDecoration(
          counterText: "", // Hides the "0/1" character counter
          contentPadding: EdgeInsets.zero, // Helps center text vertically in small boxes
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.f8),
            borderSide: BorderSide(color: AppConstants.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.f8),
            borderSide: BorderSide(color: AppConstants.grey),
          ),
        ),
      ),
    );
  }
}