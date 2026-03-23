import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:flutter/material.dart';

class CustomMaintenanceList extends StatelessWidget {
  const CustomMaintenanceList({super.key, required this.filter});

  final ExploreFilter filter;

  @override
  Widget build(BuildContext context) {
    final items = mockServices.where((s) {
      final okDistance = s.distanceKm <= filter.maxDistanceKm;
      final okRating = s.rating >= filter.minRating;
      return okDistance && okRating;
    }).toList();

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No service centers match your filters.',
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return Column(
      children: items
          .map(
            (s) => Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.name,
                          style: const TextStyle(
                            color: AppColors.veryDarkBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${s.distanceKm.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          color: AppColors.blueText,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < s.rating.floor()
                              ? Icons.star
                              : Icons.star_half,
                          color: const Color(0xFFFFBF00),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        s.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: AppColors.veryDarkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyanColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        AppConstants.bookNow,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
