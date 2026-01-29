import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class RecommendedContainer extends StatelessWidget {
  const RecommendedContainer({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.price,
    this.onTap,
  });
  final String? title;
  final String? subTitle;
  final String? price;
  final String? image;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecorationWidget.customBoxDecoration(),
        width: SizeConfig.width(context) * 0.75,
        height: SizeConfig.height(context) * 0.35,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: SizeConfig.height(context) * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage(image ?? AppImagePath.carImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? AppConstants.toyotaCamry,
                    style: AppStyle.titleOfContainer,
                  ),
                  Text(
                    subTitle ?? AppConstants.sedan,
                    style: AppStyle.containerSubtitle,
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.031),
                  Row(
                    children: [
                      Text(
                        price ?? AppConstants.price,
                        style: AppStyle.viewAll.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.f16,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppConstants.viewDetails,
                        style: AppStyle.containerBlodSubtitle,
                      ),
                      const Icon(
                        Icons.arrow_right_alt,
                        color: AppColors.cyanColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
