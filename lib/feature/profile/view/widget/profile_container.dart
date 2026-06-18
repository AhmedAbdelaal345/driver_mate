import 'dart:io';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;
    final avatarBg = theme.brightness == Brightness.dark
        ? AppColors.veryDarkBlue
        : AppColors.white;

    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
      ).copyWith(color: cardColor),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarBg,
          radius: AppFontSize.f25,
          child: _buildImage(context),
        ),
        title: Text(
          name ?? AppStrings.of(context).account,
          style: AppStyle.titleOfContainer.copyWith(
            fontSize: AppFontSize.f18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          email ?? AppStrings.of(context).emailAddress,
          style: AppStyle.containerSubtitle.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
            backgroundColor: WidgetStatePropertyAll(cardColor),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                side: BorderSide(color: AppColors.cyanColor, width: 1),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(AppStrings.of(context).edit, style: AppStyle.viewAll),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final img = image ?? '';
    if (img.isEmpty) return SvgPicture.asset(AppImagePath.profileIconPath);
    if (img.startsWith('C:') ||
        img.startsWith('/data') ||
        img.startsWith('/storage')) {
      return ClipOval(
        child: Image.file(File(img), width: 50, height: 50, fit: BoxFit.cover),
      );
    }
    if (img.endsWith('.svg')) return SvgPicture.asset(img);
    if (img.startsWith("https") || img.startsWith("http")) {
      return ClipOval(
        child: Image.network(
          img,
          width: SizeConfig.width(context) * 0.25,
          height: SizeConfig.width(context) * 0.25,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(img, width: 50, height: 50, fit: BoxFit.cover);
  }
}
