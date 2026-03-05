import 'package:flutter/material.dart';

enum NotificationCategory { all, maintenance, emergency, tips, system }

class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final NotificationCategory category;
  final IconData icon;

  const NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
    required this.category,
    required this.icon,
  }); 
}