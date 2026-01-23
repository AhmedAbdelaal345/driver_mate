import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Explore Page', style: AppStyle.labelStyle)),
    );
  }
}
