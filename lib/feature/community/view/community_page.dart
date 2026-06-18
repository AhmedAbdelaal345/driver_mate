import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/view/community_filter_page.dart';
import 'package:driver_mate/feature/community/view/community_new_post_page.dart';
import 'package:driver_mate/feature/community/view/widget/all_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_tab_bar_widget.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/review_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/explore/view/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentTab = 0;
  // late final CommunityPostCubit _postCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      AppStrings.of(context).all,
      AppStrings.of(context).questions,
      AppStrings.of(context).problems,
      AppStrings.of(context).tips,
      AppStrings.of(context).reviews,
      AppStrings.of(context).marketPlace,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).community,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyNavigation.navigateTo(ExplorePage());
            },
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: () {
              MyNavigation.navigateTo(CommunityFilterPage());
            },
            icon: Icon(Icons.tune, color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyanColor,
        child: const Icon(Icons.add, color: AppColors.white),
        onPressed: () {
          MyNavigation.navigateTo(
            BlocProvider.value(
              value: context.read<CommunityPostCubit>(),
              child: const CommunityNewPostPage(),
            ),
          );
        },
      ),

      body: Column(
        children: [
          CommunityTabBar(
            tabs: tabs,
            selectedIndex: _currentTab,
            onChanged: (i) => setState(() => _currentTab = i),
          ),

          Expanded(
            child: IndexedStack(
              index: _currentTab,
              children: const [
                AllTab(), // Create this to wrap PostHeader + QuestionCards
                QuestionTab(), // Question only
                ProblemsTab(), // Already has the AI help logic
                TipsTab(), // Now includes the header
                ReviewsTab(), // Now includes the Dark ReviewHeader
                MarketplaceTab(), // Now includes MarketplacePostHeader
              ],
            ),
          ),
        ],
      ),
    );
  }
}
