import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/profile/view/widget/booking_detail_card.dart';
import 'package:flutter/material.dart';

class MaintenanceHistory extends StatelessWidget {
  const MaintenanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB), // Light grey background from UI
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: Text("Maintenance History", style: AppStyle.appBarTitle),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [

          // 1. Summary Cards (Upcoming & Completed)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      label: "UPCOMING",
                      count: "2",
                      dotColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      label: "COMPLETED",
                      count: "2",
                      dotColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Filter Tabs (Horizontal List)
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All", isSelected: true),
                  _buildFilterChip("Upcoming"),
                  _buildFilterChip("Completed"),
                  _buildFilterChip("Canceled"),
                ],
              ),
            ),
          ),

          // 3. Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                "ALL BOOKINGS",
                style: AppStyle.hintStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // 4. List of Booking Cards
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: BookingDetailCard(), // Use the modular card widget
                  );
                },
                childCount: 3, // Actual data length
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Summary Card Helper
  Widget _buildSummaryCard({
    required String label,
    required String count,
    required Color dotColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 8, color: dotColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Filter Chip Helper
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          // TODO: Implement filtering logic
        },
        child: Chip(
          backgroundColor: isSelected ? AppColors.veryDarkBlue : Colors.white,
          side: BorderSide(color: Colors.grey.shade100),
          label: Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
          ),
        ),
      ),
    );
  }
}
