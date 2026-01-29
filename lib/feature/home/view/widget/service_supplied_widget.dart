import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class ServiceSuppliedWidget extends StatelessWidget {
  const ServiceSuppliedWidget({
    super.key,
    this.title,
    this.distance,
    this.rate,
    this.numberOfReviews,
    this.first,
    this.second,
    this.third,
  });
  final String? title;
  final String? distance;
  final String? rate;
  final String? numberOfReviews;
  final String? first, second, third;
  @override
  Widget build(BuildContext context) {
    final List<String?> item = [first, second, third];
    return Container(
      width: SizeConfig.width(context) * 0.72,

      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f16,
      ),
      padding: EdgeInsets.all(AppFontSize.f16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title ?? AppConstants.premiumAutoService,
            style: AppStyle.titleOfContainer,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.cyanColor,
                fontWeight: FontWeight.bold,
                size: AppFontSize.f13,
              ),
              SizedBox(width: AppFontSize.f5),
              Text(
                distance ?? AppConstants.dist,
                style: AppStyle.viewAll.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.height(context) * 0.015),
          Row(
            children: [
              Icon(Icons.star_rounded, color: AppColors.orange),
              Text(rate ?? "4.8", style: AppStyle.titleForContainer),
              Text(
                numberOfReviews ?? " (234 reviews)",
                style: AppStyle.containerSubtitle,
              ),
            ],
          ),

          SizedBox(height: SizeConfig.height(context) * 0.015),

          // Instead of ListView.separated, use this:
          Wrap(
            spacing: 8, // space between chips
            children: item
                .where((i) => i != null)
                .map(
                  (text) => Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecorationWidget.customBoxDecoration()
                        .copyWith(
                          color: AppColors.containerGrey,
                          borderRadius: BorderRadius.circular(AppFontSize.f18),
                        ),
                    child: Text(text!, style: AppStyle.containerSubtitle),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: SizeConfig.height(context) * 0.015),
          PrimaryElevatedButtonWidget(
            buttonText: AppConstants.bookNow,
            onPressed: () {},
          ).copyWith(backgroundColor: AppColors.cyanColor),
          // SizedBox(height: SizeConfig.height(context) * 0.015),
        ],
      ),
    );
  }
}
