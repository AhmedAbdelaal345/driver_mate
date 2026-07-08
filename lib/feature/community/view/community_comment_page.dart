import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:driver_mate/feature/community/view/widget/comment_card_widget.dart';
import 'package:driver_mate/feature/community/view/widget/question_details_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCommentPage extends StatefulWidget {
  const CommunityCommentPage({super.key, required this.post});

  final CommunityFetchPostModel post;

  @override
  State<CommunityCommentPage> createState() => _CommunityCommentPageState();
}

class _CommunityCommentPageState extends State<CommunityCommentPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Single fetch on open — cubit owns all mutations after this
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

    context.read<CommunityCommentCubit>().addComment(widget.post.id, text);

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.postdetails,
          style: AppStyle.socialButtonTextStyle.copyWith(
            fontSize: AppFontSize.f20,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Post details ───────────────────────────────────────────
          QuestionDetailsCardWidget(
            post: CommunityFetchPostModel(
              id: widget.post.id,
              title: widget.post.title,
              content: widget.post.content,
              authorName: widget.post.authorName,
              createdAt: widget.post.createdAt.toString(),
              postType: 0,
              commentCount: widget.post.commentCount,
              imagesCount: widget.post.imagesCount,
              isLikedByCurrentUser: widget.post.isLikedByCurrentUser,
              likeCount: widget.post.likeCount,
            ),
          ),

          // ── Comments list ──────────────────────────────────────────
          Expanded(
            child: BlocBuilder<CommunityCommentCubit, CommunityCommentState>(
              builder: (context, state) {
                if (state is CommunityCommentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.cyanColor,
                    ),
                  );
                }

                if (state is CommunityCommentError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.message,
                          style: AppStyle.containerSubtitle.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => context
                              .read<CommunityCommentCubit>()
                              .fetchCommentsForPost(widget.post.id),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: AppColors.cyanColor),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is CommunityCommentLoaded) {
                  if (state.comments.isEmpty) {
                    return Center(
                      child: Text(
                        'No comments yet. Be the first!',
                        style: AppStyle.containerSubtitle.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.comments.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) => CommentCard(
                      comment: state.comments[index],
                      postId: widget.post.id,
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),

          // ── Add comment input ──────────────────────────────────────
          _CommentInputBar(
            controller: _commentController,
            onSubmit: _submitComment,
          ),
        ],
      ),
    );
  }
}

// ── Bottom input bar — extracted so it doesn't rebuild with the list ──────
class _CommentInputBar extends StatelessWidget {
  const _CommentInputBar({required this.controller, required this.onSubmit});

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? theme.colorScheme.surface,
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
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.comment, color: theme.iconTheme.color),
                  hintText: 'Write your comment...',
                ),
                onFieldSubmitted: (_) => onSubmit(),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onSubmit,
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
    );
  }
}
