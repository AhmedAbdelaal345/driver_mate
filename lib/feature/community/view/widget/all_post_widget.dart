import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:driver_mate/feature/community/view/widget/question_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/problem_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/tips_tab_widget.dart';
import 'package:driver_mate/feature/community/view/widget/market_place_widget.dart';

class AllPostsList extends StatelessWidget {
  const AllPostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityPostCubit, CommunityPostState>(
      builder: (context, state) {
        final posts = state.posts;

        if (posts.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No posts yet"),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            switch (post.type) {
              case "Question":
                return QuestionCard(post: post);

              case "Problem":
                return ProblemCard(post: post);

              case "Tip":
                return TipCard(post: post);

              case "Marketplace":
                return MarketplaceCard(post: post);

              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }
}