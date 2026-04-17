import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_cubit.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDialogWidget extends StatelessWidget {
  const ShowDialogWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title),
      content: Text(content),
      backgroundColor: AppColors.white,

      actions: [
        Row(
          children: [
            Expanded(
              child: PrimaryElevatedButtonWidget(
                backgroundColor: AppColors.white,

                onPressed: () {
                  Navigator.pop(context);
                },
                buttonText: AppConstants.cancel,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PrimaryElevatedButtonWidget(
                backgroundColor: AppColors.blue,
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().logout(context);
                },
                buttonText: AppConstants.logout,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
