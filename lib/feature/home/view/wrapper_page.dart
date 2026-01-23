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
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.cyanColor,
        unselectedItemColor: AppColors.iconGrey,
        selectedFontSize: AppFontSize.f29,
        unselectedFontSize: AppFontSize.f25,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              icon: SvgPicture.asset(
                AppImagePath.compassIconPath,
                fit: BoxFit.scaleDown,
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              icon: SvgPicture.asset(
                AppImagePath.repboteIconPath,
                fit: BoxFit.scaleDown,
              ),
            ),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              icon: SvgPicture.asset(AppImagePath.homeIconPath),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
              icon: SvgPicture.asset(AppImagePath.peopleIconPath),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
              icon: SvgPicture.asset(AppImagePath.profileIconPath),
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatActionButtonWidget(onPressed: () {}),
    );
  }
}
