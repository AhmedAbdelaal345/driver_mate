import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:driver_mate/feature/community/view/widget/comment_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_details_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCommentPage extends StatefulWidget {
  const CommunityCommentPage({super.key, required this.post});

  final CommunityPostModel post;

  @override
  State<CommunityCommentPage> createState() => _CommunityCommentPageState();
}

class _CommunityCommentPageState extends State<CommunityCommentPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch once — never re-fetched unless user pulls to refresh
    context.read<CommunityCommentCubit>().fetchCommentsForPost(widget.post.id);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    // addComment is now synchronous optimistic update — no await needed
    context.read<CommunityCommentCubit>().addComment(widget.post.id, text);
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          AppStrings.of(context).postdetails,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Post details ───────────────────────────────────────
          QuestionDetailsCardWidget(post: widget.post),

          // ── Comments list ──────────────────────────────────────
          Expanded(
            child: BlocBuilder<CommunityCommentCubit, CommunityCommentState>(
              // buildWhen prevents rebuild when state type doesn't change
              // and the reference is the same — improves performance
              buildWhen: (prev, curr) => curr is! CommunityCommentInitial,
              builder: (context, state) {
                if (state is CommunityCommentLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  );
                }

                if (state is CommunityCommentError) {
                  return Center(child: Text(state.message));
                }

                if (state is CommunityCommentLoaded) {
                  if (state.comments.isEmpty) {
                    return Center(
                      child: Text(
                        'No comments yet. Be the first!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      return CommentCard(comment: state.comments[index]);
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),

          // ── Add comment input ──────────────────────────────────
          Flexible(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.comment,
                            color: AppColors.iconGrey,
                          ),
                          hintText: 'Write your comment...',
                          filled: true,
                          fillColor: AppColors.midGrey.withValues(alpha: 0.08),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onFieldSubmitted: (_) => _submitComment(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _submitComment,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.cyanColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.send, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
