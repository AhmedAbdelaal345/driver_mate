import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';
import '../utils/app_font_size.dart';

enum NotifierType { success, error, warning }

class AppNotifier {
  static void show(
    BuildContext context,
    String message, {
    NotifierType type = NotifierType.success,
  }) {
    final Color bgColor = _getColor(type);

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      _showSnackBar(context, message, bgColor);
    } else {
      _showToast(message, bgColor);
    }
  }

  static void _showSnackBar(
    BuildContext context,
    String message,
    Color bgColor,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(fontSize: AppFontSize.f14, color: Colors.white),
          ),
          backgroundColor: bgColor,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  static void _showToast(String message, Color bgColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: AppFontSize.f14,
    );
  }

  static Color _getColor(NotifierType type) {
    switch (type) {
      case NotifierType.error:
        return AppColors.red;
      case NotifierType.warning:
        return AppColors.orange;
      case NotifierType.success:
        return AppColors.darkBlue;
    }
  }
}
