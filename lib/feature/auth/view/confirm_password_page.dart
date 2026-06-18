import 'package:driver_mate/core/helper/my_navigation.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_cubit.dart';
import 'package:driver_mate/feature/auth/view/set_new_password.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordPage extends StatelessWidget {
  const ConfirmPasswordPage({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: LeadingIcon(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.04,
        ),
        child: Column(
          children: [
            SizedBox(height: 0.047 * SizeConfig.height(context)),
            ContainerForIcon(iconPath: AppImagePath.peopleIconPath),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.of(context).passwordRest,
                style: AppStyle.labelStyle.copyWith(
                  fontSize: AppFontSize.f20,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            SizedBox(height: 0.014 * SizeConfig.height(context)),
            Text(
              AppStrings.of(context).confirmPassword,
              style: AppStyle.hintStyle.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(height: 0.041 * SizeConfig.height(context)),
            PrimaryElevatedButtonWidget(
              buttonText: AppStrings.of(context).confirm,
              onPressed: () {
                // WHY addPostFrameCallback:
                // onPressed is called inside a button's GestureDetector
                // callback, which runs during an event dispatch pass.
                // GetX pushes the new route synchronously, which triggers a
                // Focus scope transfer. If any ancestor widget is currently
                // building (e.g. a BlocBuilder above this page just emitted),
                // the Focus ancestry check fails.
                //
                // Deferring to the next frame guarantees the current frame is
                // fully painted and all dirty elements are flushed before the
                // route push disturbs the element tree.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  MyNavigation.navigateTo(
                    BlocProvider.value(
                      value: context.read<OtpCubit>(),

                      child: SetNewPasswordPage(email: email, otp: otp),
                    ),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
