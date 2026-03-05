import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key, this.title, this.count, this.onTap});
  final String? title;
  final int? count;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppFontSize.f8),
          decoration: BoxDecorationWidget.customBoxDecoration(borderRadius: 16)
              .copyWith(
                border: BoxBorder.fromLTRB(
                  left: const BorderSide(
                    color: AppColors.darkCyanColor,
                    width: 3,
                  ),
                ),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(count.toString(), style: AppStyle.titleOfContainer),
              const SizedBox(height: 10),
              Text(
                title ?? AppConstants.myCars,
                style: AppStyle.containerSubtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
