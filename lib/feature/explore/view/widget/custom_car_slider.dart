import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
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
      final okCategory = filter.category == 'All' || c.category == filter.category;
      final okPrice = c.price >= filter.minPrice && c.price <= filter.maxPrice;
      return okCategory && okPrice;
    }).toList();

    if (cars.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          AppConstants.notMatch,
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return Column(
      children: cars
          .map(
            (car) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _ExploreCarCard(
                car: car,
                onViewDetails: onViewDetails,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ExploreCarCard extends StatelessWidget {
  const _ExploreCarCard({required this.car, this.onViewDetails});

  final CarItem car;
  final void Function(CarItem car)? onViewDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  car.image,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              if (car.isNew)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      AppConstants.newLabel,
                      style: TextStyle(
                        color: AppColors.cyanColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.title,
                  style: const TextStyle(
                    color: AppColors.veryDarkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  car.subtitle,
                  style: const TextStyle(
                    color: AppColors.cyanColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  car.details,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () => onViewDetails?.call(car),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      AppConstants.viewDetails,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
