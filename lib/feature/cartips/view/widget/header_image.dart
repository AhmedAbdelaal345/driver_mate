import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/cartips/view/widget/custom_chip.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
    required this.assetName,
    this.hintText,
    this.labelText,
  });
  final String assetName;
  final String? hintText;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height(context) * 0.5,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // IMAGE
          Container(
            height: SizeConfig.height(context) * 0.4,
            decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
              image: DecorationImage(
                image: AssetImage(assetName),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // CARD (overlapping image)
          Positioned(
            bottom: 10, // يخلي الكارت نازل تحت الصورة وجزء منه فوقها
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecorationWidget.customBoxDecoration().copyWith(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      //custom chip
                      CustomChip(),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.iconGrey,
                      ),
                      const SizedBox(width: 4),
                      Text("5 min read", style: AppStyle.hintStyle),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    labelText ?? AppConstants.essentialCar,
                    style: AppStyle.titleForContainer,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
