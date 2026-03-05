import 'package:flutter/material.dart';

class BookingDetailCard extends StatelessWidget {
  const BookingDetailCard({
    super.key,
    required this.centerName,
    required this.location,
    required this.service,
    required this.state,
    required this.date,
    required this.price,
  });
  final String centerName;
  final String location;
  final String service;
  final String state;
  final DateTime date;
  final double price;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    centerName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    service,
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
          Divider(height: 24),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            date.toString(), //"Jan 30, 2024 • 10:00 AM",
          ),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.location_on_outlined, location),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.attach_money, price.toString(), isPrice: true),
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
