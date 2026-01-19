import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({
    super.key,
    required this.textButton,
    required this.icon, // This will now accept any Widget (Image, Icon, Svg, etc.)
    required this.onPressed,
  });

  final String textButton;
  final Widget icon; // Changed from ImageIcon to Widget
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.01,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom( // Simplified style syntax
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppFontSize.f8),
          ),
          elevation: 0, // Optional: standard for social buttons
          backgroundColor: Colors.white, // Optional: usually social buttons are white/light grey
          side: BorderSide(color: AppColors.grey), // Optional: adds a border
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Wrap icon in a SizedBox to control size if needed
            SizedBox(
              width: AppFontSize.f25,
              height: AppFontSize.f25,
              child: icon, 
            ),
            const SizedBox(width: 10),
            // 2. Fixed: Use the passed variable textButton
            Text(
              textButton, 
              style: AppStyle.socialButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}