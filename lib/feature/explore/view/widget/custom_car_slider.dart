import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class CustomCarSlider extends StatelessWidget {
  const CustomCarSlider({
    super.key,
    this.carImagePath,
    this.carTitle,
    this.carPrice,
    this.carLocation,
  });

  final String? carImagePath; // Replace with your image path
  final String? carTitle;
  final String? carPrice;
  final String? carLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height(context) * 0.38, // Adjusted height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: SizeConfig.width(context) * 0.65,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Container
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        carImagePath ?? AppImagePath.camryCarImagePath,
                      ), // Replace path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        carTitle ?? "Toyota Camry 2021",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        carPrice ?? "\$28,000 or \$450/mo",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        carPrice ?? "Downtown Dubai",
                        style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 0.044 * SizeConfig.height(context),
                        child: PrimaryElevatedButtonWidget(
                          buttonText: AppConstants.viewDetails,
                          onPressed: () {},
                        ).copyWith(backgroundColor: AppColors.cyanColor),
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   height: 40,
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColors.cyanColor,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //     ),
                      //     onPressed: () {},
                      //     child: const Text(
                      //       "View Details",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
