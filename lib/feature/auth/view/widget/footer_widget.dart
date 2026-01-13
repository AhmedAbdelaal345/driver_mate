import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key,required this.onTap});
final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppConstants.dontHaveAccount, style: AppStyle.signUpTextStyle),
        InkWell(
          onTap: onTap,
          child: Text(
            AppConstants.signup,
            style: AppStyle.forgetPasswordStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
