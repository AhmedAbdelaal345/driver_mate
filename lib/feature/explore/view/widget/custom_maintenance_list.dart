import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/explore/data/explore_filter.dart';
import 'package:driver_mate/feature/explore/data/explore_mock.dart';
import 'package:flutter/material.dart';

class CustomMaintenanceList extends StatelessWidget {
  const CustomMaintenanceList({super.key, required this.filter});

  final ExploreFilter filter;

  @override
  Widget build(BuildContext context) {
    // لو Tips مختارة نخفي maintenance section
    if (filter.category == "Tips") {
      return const SizedBox.shrink();
    }

    final items = mockServices.where((s) {
      final okDistance = s.distanceKm <= filter.maxDistanceKm;
      final okRating = s.rating >= filter.minRating;
      return okDistance && okRating;
    }).toList();

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          "No service centers match your filters.",
          style: TextStyle(color: AppColors.textGrey),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final s = items[index];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecorationWidget.customBoxDecoration(),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${s.distanceKm.toStringAsFixed(1)} km",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          s.rating.toStringAsFixed(1),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 32,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cyanColor,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          AppConstants.bookNow,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
