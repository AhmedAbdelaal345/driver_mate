import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, this.firstText, this.secondText});
  final String? firstText;
  final String? secondText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
        color: AppColors.lightBleu,
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            firstText ?? AppConstants.keepYourInfo,
            style: AppStyle.boldSmallText,
          ),
          Text(
            secondText ?? AppConstants.informationHelp,
            style: AppStyle.regularSmallText,
          ),
        ],
      ),
    );
  }
}
