import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:flutter/material.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        MyNavigation.navigateBack();
      },
      icon: Icon(Icons.arrow_back_ios, size: 18),
    );
  }
}
