import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/Ai/view/ai_page.dart';
import 'package:driver_mate/feature/community/view/community_page.dart';
import 'package:driver_mate/feature/explore/view/explore_page.dart';
import 'package:driver_mate/feature/home/view/home_page.dart';
import 'package:driver_mate/feature/home/view/widget/float_action_button_widget.dart';
import 'package:driver_mate/feature/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  final List<Widget> _pages = [
    ExplorePage(),
    AiPage(),
    HomePage(),
    CommunityPage(),
    ProfilePage(),
  ];
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.cyanColor,
        unselectedItemColor: AppColors.iconGrey,
        selectedFontSize: AppFontSize.f18,
        unselectedFontSize: AppFontSize.f14,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImagePath.compassIconPath, height: 24),
            activeIcon: SvgPicture.asset(
              AppImagePath.compassIconPath,
              colorFilter: ColorFilter.mode(
                AppColors.cyanColor,
                BlendMode.srcIn,
              ),
              height: 26,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImagePath.repboteIconPath, height: 24),
            activeIcon: SvgPicture.asset(
              AppImagePath.repboteIconPath,
              colorFilter: ColorFilter.mode(
                AppColors.cyanColor,
                BlendMode.srcIn,
              ),
              height: 26,
            ),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImagePath.homeIconPath, height: 24),
            activeIcon: SvgPicture.asset(
              AppImagePath.homeIconPath,
              colorFilter: ColorFilter.mode(
                AppColors.cyanColor,
                BlendMode.srcIn,
              ),
              height: 26,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImagePath.peopleIconPath, height: 24),
            activeIcon: SvgPicture.asset(
              AppImagePath.peopleIconPath,
              colorFilter: ColorFilter.mode(
                AppColors.cyanColor,
                BlendMode.srcIn,
              ),
              height: 26,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImagePath.profileIconPath, height: 24),
            activeIcon: SvgPicture.asset(
              AppImagePath.profileIconPath,
              colorFilter: ColorFilter.mode(
                AppColors.cyanColor,
                BlendMode.srcIn,
              ),
              height: 26,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatActionButtonWidget(onPressed: () {}),
    );
  }
}
