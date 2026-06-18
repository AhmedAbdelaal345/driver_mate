// feature/community/view/widget/all_tab_widget.dart
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/feature/community/view/widget/all_post_widget.dart';
import 'package:driver_mate/feature/community/view/widget/community_post_header.dart';
import 'package:flutter/material.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  [
        CommunityPostHeader(
          postType: AppStrings.of(context).all,
        ), // The "Ask a question" header we built
        AllPostsList(),

      ],
    );
  }
}
