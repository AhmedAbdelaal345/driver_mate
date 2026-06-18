import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckTextfieldWidget extends StatelessWidget {
  const CheckTextfieldWidget({
    super.key,
    required this.validator,
    required this.controllers,
    this.onChanged,
    this.index, // Optional: if you want to pass extra logic from parent
  });

  final String? Function(String?)? validator;
  final List<TextEditingController>? controllers;
  final int? index;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.068 * SizeConfig.width(context),
      height: 0.13 * SizeConfig.height(context), // Fixed typo: 013 -> 0.13
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller:
            controllers?[index ?? 0], // Safely access controller based on index
        validator: validator,
        textAlign: TextAlign.center, // Centers the number inside the box
        // --- KEY CHANGE HERE ---
        onChanged: (value) {
          /// HANDLE PASTE
          if (value.length > 1 && controllers != null && index != null) {
            final chars = value.split('');

            for (int i = 0; i < chars.length; i++) {
              final targetIndex = index! + i;

              if (targetIndex < controllers!.length) {
                controllers![targetIndex].text = chars[i];
              }
            }

            /// move focus to last filled field
            final next = index! + chars.length;

            if (next < controllers!.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  FocusScope.of(context).nextFocus();
                }
              });
            } else {
              FocusScope.of(context).unfocus();
            }

            return;
          }

          /// NORMAL INPUT
          if (value.length == 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                FocusScope.of(context).nextFocus();
              }
            });
          }

          if (onChanged != null) {
            onChanged!(value);
          }
        },
        // -----------------------
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
          signed: false,
        ),

        decoration: InputDecoration(
          counterText: "", // Hides the "0/1" character counter
          contentPadding:
              EdgeInsets.zero, // Helps center text vertically in small boxes
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f8),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f8),
            borderSide: BorderSide(color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
