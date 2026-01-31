import 'package:flutter/material.dart';

class BookingDetailCard extends StatelessWidget {
  const BookingDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Auto Care Center",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "Oil Change & Filter",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  // TODO: Navigate to specific booking details
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            "Jan 30, 2024 • 10:00 AM",
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_outlined, "Downtown Plaza, Main S"),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.attach_money, "45", isPrice: true),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Upcoming",
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Logic for individual booking action
                },
                child: const Text(
                  "View Details",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isPrice = false}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isPrice ? Colors.blue : Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      ],
    );
  }
}
