import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/Ai/view/ai_page.dart';
import 'package:driver_mate/feature/community/view/community_page.dart';
import 'package:driver_mate/feature/explore/view/explore_page.dart';
import 'package:driver_mate/feature/home/view/home_page.dart';
import 'package:driver_mate/feature/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _currentIndex = 2;

  // Build once & keep state for each tab via IndexedStack
  late final List<Widget> _pages = const [
    ExplorePage(),
    AiPage(),
    HomePage(),
    CommunityPage(),
    ProfilePage(),
  ];

  Widget _navIcon(String path, {bool active = false}) {
    return SvgPicture.asset(
      path,
      colorFilter: active
          ? const ColorFilter.mode(AppColors.cyanColor, BlendMode.srcIn)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.cyanColor,
        unselectedItemColor: AppColors.iconGrey,
        selectedFontSize: AppFontSize.f12,
        unselectedFontSize: AppFontSize.f11,
        unselectedLabelStyle: const TextStyle(overflow: TextOverflow.visible),
        selectedLabelStyle: const TextStyle(
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w600,
        ),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _navIcon(AppImagePath.compassIconPath),
            activeIcon: _navIcon(AppImagePath.compassIconPath, active: true),
            label: AppConstants.explore, // موجودة عندك
          ),
          BottomNavigationBarItem(
            icon: _navIcon(AppImagePath.repboteIconPath),
            activeIcon: _navIcon(AppImagePath.repboteIconPath, active: true),
            label: 'AI Assistant', // لو عايزها constants ضيفها
          ),
          BottomNavigationBarItem(
            icon: _navIcon(AppImagePath.homeIconPath),
            activeIcon: _navIcon(AppImagePath.homeIconPath, active: true),
            label: 'Home', // لو عايزها constants ضيفها
          ),
          BottomNavigationBarItem(
            icon: _navIcon(AppImagePath.peopleIconPath),
            activeIcon: _navIcon(AppImagePath.peopleIconPath, active: true),
            label: 'Community', // لو عايزها constants ضيفها
          ),
          BottomNavigationBarItem(
            icon: _navIcon(AppImagePath.profileIconPath),
            activeIcon: _navIcon(AppImagePath.profileIconPath, active: true),
            label: 'Profile', // لو عايزها constants ضيفها
          ),
        ],
      ),
      // floatingActionButton: FloatActionButtonWidget(onPressed: () {}),
    );
  }
}
