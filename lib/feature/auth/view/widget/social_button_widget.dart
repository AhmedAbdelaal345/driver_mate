import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key,required this.textButton,required this.icon,required this.onPressed});
final String textButton;
final ImageIcon icon;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context) * 0.01,
                ),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.f8),
                      ),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(icon.image, size: AppConstants.f25),
                      Text(AppConstants.continueWithApple, style: AppStyle.socialButtonTextStyle),
                    ],
                  ),
                ),
              );
  }
}