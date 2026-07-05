import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/booking_details/view/booking_details_page.dart';
import 'package:driver_mate/feature/maintance_history/data/model/maintance_history_model.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/maintance_history/manager/state/maintence_history_state.dart';
import 'package:driver_mate/feature/profile/view/widget/booking_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceHistory extends StatefulWidget {
  const MaintenanceHistory({super.key});

  @override
  State<MaintenanceHistory> createState() => _MaintenanceHistoryState();
}

class _MaintenanceHistoryState extends State<MaintenanceHistory> {
  String selectedFilter = "All";
  @override
  Widget build(BuildContext context) {
    Widget _buildBody(
      BuildContext context,
      List<MaintanceHistoryModel> items,
      int upcoming,
      int completed,
    ) {
      return CustomScrollView(
        slivers: [
          /// Summary cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      label: AppStrings.of(context).upcoming,
                      count: upcoming.toString(),
                      dotColor: Theme.of(context).iconTheme.color!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      label: "COMPLETED",
                      count: completed.toString(),
                      dotColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Filter chips
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip("All"),
                  _buildFilterChip("Upcoming"),
                  _buildFilterChip("Completed"),
                  _buildFilterChip("Canceled"),
                ],
              ),
            ),
          ),

          /// Section title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                selectedFilter == "All"
                    ? "ALL BOOKINGS"
                    : "${selectedFilter.toUpperCase()} BOOKINGS",
                style: AppStyle.hintStyle.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// List of bookings
          /// List of bookings
          if (items.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  "No bookings found for this filter",
                  style: AppStyle.containerSubtitle,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = items[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: BookingDetailCard(
                      centerName: item.centerName,
                      location: item.location,
                      service: item.typeOfService,
                      state: item.state,
                      date: item.date,
                      price: item.price,
                      time: item.time,
                      onPressed: () {
                        MyNavigation.navigateTo(
                          BookingDetailsPage(booking: item),
                        );
                      },
                    ),
                  );
                }, childCount: items.length),
              ),
            ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: const LeadingIcon(),
        title: Text(
          AppStrings.of(context).maintenanceHistory,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MaintenceHistoryCubit, MaintenceHistoryState>(
        builder: (context, state) {
          if (state is MaintenceHistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MaintenceHistoryErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is MaintenceHistorySuccessState) {
            final items = state.items;
            for (var item in items) {
              print("STATE: ${item.state}");
            }
            final upcoming = items
                .where((e) => e.state.trim().toLowerCase() == "upcoming")
                .length;

            final completed = items
                .where((e) => e.state.trim().toLowerCase() == "completed")
                .length;
            final filteredItems = selectedFilter == "All"
                ? items
                : items
                      .where(
                        (e) =>
                            e.state.trim().toLowerCase() ==
                            selectedFilter.trim().toLowerCase(),
                      )
                      .toList();
            return _buildBody(context, filteredItems, upcoming, completed);
          }
          return SizedBox();
        },
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
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurface,
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
  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = label;
          });
        },
        child: Chip(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          side: BorderSide(color: Theme.of(context).colorScheme.outline),
          label: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
