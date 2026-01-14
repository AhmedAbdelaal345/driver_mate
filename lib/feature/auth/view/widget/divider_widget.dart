import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.1, // Adjusted for better visibility
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppConstants.grey,
              thickness: AppConstants.f2,
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * 0.02,
            ),
            child: Text(
              "OR",
              style: AppStyle.orTextStyle,
            ),
          ),
          
          Expanded(
            child: Divider(
              color: AppConstants.grey,
              thickness: AppConstants.f2,
            ),
          ),
        ],
      ),
    );
  }
}