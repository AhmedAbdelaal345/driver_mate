import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.comment});

  final CommunityCommentModel comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  // Local UI-only state (NOT synced to Cubit — only controls field visibility)
  bool _showReplyField = false;
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  // ── Actions — all go through Cubit, no setState for data ─────────────────

  void _handleLike() {
    // context.read: fire-and-forget, no rebuild needed here
    // The Cubit emits CommunityCommentLoaded → BlocBuilder in parent rebuilds
    context.read<CommunityCommentCubit>().likeComment(
      widget.comment.postId,
      widget.comment.commentId,
    );
  }

  void _handleAddReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;

    context.read<CommunityCommentCubit>().addReply(
      widget.comment.postId,
      widget.comment.commentId,
      text,
    );

    _replyController.clear();
    setState(() => _showReplyField = false); // only local UI toggle
  }

  void _handleDelete() {
    context.read<CommunityCommentCubit>().removeReply(
      widget.comment.postId,
      widget.comment.commentId,
      widget.comment.commentId,
    );
  }

  void _handleEdit() {
    _showEditDialog(context);
  }

  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.midGrey.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Text(
                  widget.comment.authorInitials,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.comment.authorName,
                      style: AppStyle.socialButtonTextStyle.copyWith(
                        fontSize: AppFontSize.f14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      widget.comment.createdAt.toString().substring(0, 16),
                      style: TextStyle(
                        color: Theme.of(context).iconTheme.color,
                        fontSize: AppFontSize.f11,
                      ),
                    ),
                  ],
                ),
              ),
              // ── Edit / Delete menu ─────────────────────────
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') _handleDelete();
                  if (value == 'edit') _handleEdit();
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'edit', child: Text('Edit')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Content ───────────────────────────────────────────
          Text(
            widget.comment.content,
            style: AppStyle.containerSubtitle.copyWith(height: 1.4),
          ),

          const SizedBox(height: 14),

          // ── Actions row ───────────────────────────────────────
          Row(
            children: [
              // Like button — IconButton only, no wrapping GestureDetector
              IconButton(
                onPressed: _handleLike,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  widget.comment.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  size: 20,
                  color: widget.comment.isLiked
                      ? AppColors.red
                      : AppColors.iconGrey,
                ),
              ),

              const SizedBox(width: 6),

              Text(
                widget.comment.numberOfLikes.toString(),
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: AppFontSize.f13,
                ),
              ),

              const SizedBox(width: 20),

              // Reply toggle — local UI only
              GestureDetector(
                onTap: () => setState(() => _showReplyField = !_showReplyField),
                child: Text(
                  _showReplyField ? 'Cancel' : 'Reply',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),

              if (widget.comment.replies.isNotEmpty) ...[
                const SizedBox(width: 16),
                Text(
                  '${widget.comment.replies.length} ${widget.comment.replies.length == 1 ? 'reply' : 'replies'}',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: AppFontSize.f12,
                  ),
                ),
              ],
            ],
          ),

          // ── Reply input field ─────────────────────────────────
          if (_showReplyField) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _replyController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Write a reply...',
                      filled: true,
                      fillColor: AppColors.midGrey.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _handleAddReply,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // ── Recursive replies ─────────────────────────────────
          // Indented left — same CommentCard widget, works at any depth
          if (widget.comment.replies.isNotEmpty) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: widget.comment.replies
                    .map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CommentCard(comment: reply),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Edit dialog ───────────────────────────────────────────────────────────
  void _showEditDialog(BuildContext context) {
    final controller = TextEditingController(text: widget.comment.content);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit Comment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(
              context,
            ).colorScheme.surface.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;

              // Use outer context which has CommunityCommentCubit in tree
              context.read<CommunityCommentCubit>().editReply(
                widget.comment.postId,
                widget.comment.commentId,
                widget.comment.commentId,
                text,
              );

              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
