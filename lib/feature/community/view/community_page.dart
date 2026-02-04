import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/view/community_filter_page.dart';
import 'package:driver_mate/feature/community/view/community_new_post_page.dart';
import 'package:driver_mate/feature/community/view/widget/all_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_tabBar_widget.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/review_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:driver_mate/feature/community/data/repo/community_post_repo.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _currentTab = 0;
  late final CommunityPostCubit _postCubit;

  final tabs = const [
    AppConstants.all,
    AppConstants.questions,
    AppConstants.problems,
    AppConstants.tips,
    AppConstants.reviews,
    AppConstants.marketPlace,
  ];

  @override
  void initState() {
    super.initState();
    _postCubit =
        CommunityPostCubit(repo: InMemoryCommunityPostRepository())..loadPosts();
  }

  @override
  void dispose() {
    _postCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _postCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.community,
            style: AppStyle.socialButtonTextStyle.copyWith(
              fontSize: AppFontSize.f20,
            ),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
              onPressed: () {
                MyNavigation.navigateTo(CommunityFilterPage());
              },
              icon: const Icon(Icons.tune),
            ),
          ],
        ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyanColor,
        child: const Icon(Icons.add, color: AppColors.white),
        onPressed: () {
          MyNavigation.navigateTo(
            BlocProvider.value(
              value: _postCubit,
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
      ),
    );
  }
}
