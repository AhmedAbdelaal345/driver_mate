import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    super.key,
    this.email,
    this.name,
    this.image,
    this.onPressed,
  });
  final String? name;
  final String? email;
  final String? image;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.white,
          radius: AppFontSize.f25,
          child: SvgPicture.asset(image ?? AppImagePath.profileIconPath),
        ),
        title: Text(
          name ?? AppConstants.user,
          style: AppStyle.titleOfContainer.copyWith(fontSize: AppFontSize.f18),
        ),
        subtitle: Text(
          email ?? AppConstants.emailAddress,
          style: AppStyle.containerSubtitle,
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsetsGeometry.all(20)),
            iconColor: const WidgetStatePropertyAll(
              AppColors.boarderWhiteColor,
            ),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
                side: BorderSide(color: AppColors.cyanColor, width: 1),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(AppConstants.edit, style: AppStyle.viewAll),
        ),
      ),
    );
  }
}
