// feature/community/view/widget/all_tab_widget.dart
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_list.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:flutter/material.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CommunityPostHeader(), // The "Ask a question" header we built
        CommunityPostList(showEmptyState: false),
        QuestionCard(), // A question
        ProblemCard(), // A problem with AI help
        TipCard(), // A helpful tip
        MarketplaceCard(), // An item for sale
      ],
    );
  }
}
