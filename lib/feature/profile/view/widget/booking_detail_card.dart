import 'package:driver_mate/core/utils/box_decoration.dart';
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
    required this.time,
    required this.onPressed,
  });
  final String centerName;
  final String location;
  final String service;
  final String state;
  final String time;
  final DateTime date;
  final double price;

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      centerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      service,
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon:  Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
          Divider(height: 24),
          _buildInfoRow(
            Icons.calendar_today_outlined,
            "month: ${date.month}, day: ${date.day}, ${date.year} • $time ", //"Jan 30, 2024 • 10:00 AM",
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
                  color: _getStateColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  
                ),
                child: Text(
                  state,
                  style: TextStyle(color: _getStateColor(), fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: onPressed,
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

  Color _getStateColor() {
    switch (state.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "canceled":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
