import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.of(context).dontHaveAccount,
          style: AppStyle.signUpTextStyle.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            AppStrings.of(context).signup,
            style: AppStyle.forgetPasswordStyle.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
