import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:driver_mate/feature/explore/data/model/explore_model.dart';
import 'package:flutter/material.dart';

class CustomCarSlider extends StatelessWidget {
  const CustomCarSlider({super.key, required this.filter, this.onViewDetails});

  final ExploreFilter filter;
  final void Function(CarItem car)? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final cars = mockCars.where((c) {
      // If 'All' is selected, show everything.
      // If 'Cars' is selected, you could filter by a specific sub-category like 'Sedan' or 'SUV'
      final okCategory =
          filter.category == "All" || c.category == filter.category;

      final okPrice = c.price >= filter.minPrice && c.price <= filter.maxPrice;
      return okCategory && okPrice;
    }).toList();

    if (cars.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          AppConstants.notMatch,
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return SizedBox(
      height: SizeConfig.height(context) * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];

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
                // 🖼 Image (EXPANDED بدل height ثابت)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      image: DecorationImage(
                        image: AssetImage(car.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${car.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        car.location,
                        style: const TextStyle(
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
                          onPressed: () => onViewDetails?.call(car),
                        ).copyWith(backgroundColor: AppColors.cyanColor),
                      ),
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
