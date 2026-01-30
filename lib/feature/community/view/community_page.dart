import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/view/widget/all_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_tabBar_widget.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/review_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentTab = 0;

  final tabs = const [
    AppConstants.all,
    AppConstants.questions,
    AppConstants.problems,
    AppConstants.tips,
    AppConstants.reviews,
    AppConstants.marketPlace,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.community,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyanColor,
        child: const Icon(Icons.add, color: AppColors.white),
        onPressed: () {
          // here we will add the functionality for navigate to specific page
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
