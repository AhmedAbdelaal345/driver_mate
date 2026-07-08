// feature/community/view/widget/all_tab_widget.dart
// // import 'package:driver_mate/core/utils/app_constants.dart';  
// import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/feature/community/view/widget/all_post_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:flutter/material.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Use CustomScrollView to avoid ListView-inside-ListView scroll conflicts.
    // AllPostsList uses shrinkWrap + NeverScrollableScrollPhysics internally,
    // so it must live inside a single scrollable that owns the viewport.
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CommunityPostHeader(postType: 0), // 0 = Question (default for All tab)
        ),
        const SliverToBoxAdapter(
          child: AllPostsList(),
        ),
      ],
    );
  }
}
