import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/feature/Ai/view/ai_page.dart';
import 'package:driver_mate/feature/car_details/manager/cubit/car_details_cubit.dart';
import 'package:driver_mate/feature/community/view/community_page.dart';
import 'package:driver_mate/feature/explore/view/explore_page.dart';
import 'package:driver_mate/feature/home/view/home_page.dart';
import 'package:driver_mate/feature/maintance_booking/manager/cubit/service_center_cubit.dart';
import 'package:driver_mate/feature/profile/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WrapperPage extends StatefulWidget {
  final int initialIndex;
  const WrapperPage({super.key, this.initialIndex = 2});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  late int _currentIndex;

  late final List<Widget> _pages = const [
    ExplorePage(),
    AiPage(),
    HomePage(),
    CommunityPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Widget _navIcon(String path, {bool active = false}) {
    // ── Use theme color so inactive icons adapt in dark mode ─────────────
    final inactiveColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor ??
        AppColors.iconGrey;

    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        active ? AppColors.cyanColor : inactiveColor,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navBarTheme = theme.bottomNavigationBarTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ServiceCenterCubit>(
          create: (_) => ServiceCenterCubit()..loadServiceCenters(),
        ),
        BlocProvider<CarDetailsCubit>(
          create: (_) => CarDetailsCubit()..loadCarDetails(),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: SafeArea(
            bottom: true,
            top: true,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),

              // ── All colors from theme — no hardcoding ─────────────────
              backgroundColor:
                  navBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
              selectedItemColor:
                  navBarTheme.selectedItemColor ?? AppColors.cyanColor,
              unselectedItemColor:
                  navBarTheme.unselectedItemColor ?? AppColors.iconGrey,

              selectedFontSize: AppFontSize.f12,
              unselectedFontSize: AppFontSize.f11,
              showUnselectedLabels: true,
              unselectedLabelStyle: const TextStyle(
                overflow: TextOverflow.visible,
              ),
              selectedLabelStyle: const TextStyle(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w600,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: _navIcon(AppImagePath.compassIconPath),
                  activeIcon: _navIcon(
                    AppImagePath.compassIconPath,
                    active: true,
                  ),
                  label: AppStrings.of(context).explore,
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(AppImagePath.repboteIconPath),
                  activeIcon: _navIcon(
                    AppImagePath.repboteIconPath,
                    active: true,
                  ),
                  label: AppStrings.of(context).aiAssistant,
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(AppImagePath.homeIconPath),
                  activeIcon: _navIcon(AppImagePath.homeIconPath, active: true),
                  label: AppStrings.of(context).home,
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(AppImagePath.peopleIconPath),
                  activeIcon: _navIcon(
                    AppImagePath.peopleIconPath,
                    active: true,
                  ),
                  label: AppStrings.of(context).community,
                ),
                BottomNavigationBarItem(
                  icon: _navIcon(AppImagePath.profileIconPath),
                  activeIcon: _navIcon(
                    AppImagePath.profileIconPath,
                    active: true,
                  ),
                  label: AppStrings.of(context).profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
