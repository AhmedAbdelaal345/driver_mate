import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Profile Page', style: AppStyle.labelStyle)),
    );
  }
}
