import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.comment, required this.postId});

  final CommunityGetCommentModel comment;
  final String postId;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  // Local UI-only — does NOT need to go through cubit
  bool _showReplyField = false;
  final TextEditingController _replyController = TextEditingController();

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _handleAddReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;

    context.read<CommunityCommentCubit>().addReply(
      widget.postId,
      widget.comment.commentId,
      text,
    );

    _replyController.clear();
    setState(() => _showReplyField = false);
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    if (trimmed.length == 1) return trimmed.toUpperCase();
    return trimmed.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: AppFontSize.f12,
      ).copyWith(color: cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ────────────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.cyanColor,
                child: Text(
                  _initials(widget.comment.authorName),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
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
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      _formatDate(widget.comment.createdAt),
                      style: AppStyle.containerSubtitle.copyWith(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Content ───────────────────────────────────────────────
          Text(
            widget.comment.content,
            style: AppStyle.containerSubtitle.copyWith(
              height: 1.4,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),

          const SizedBox(height: 14),

          // ── Actions row ───────────────────────────────────────────
          Row(
            children: [
              // Likes not supported at comment level (API only has post likes)
              // Shown as non-interactive placeholder for UI consistency
              GestureDetector(
                onTap: () => context.read<CommunityCommentCubit>().likeComment(
                  widget.postId,
                  widget.comment.commentId,
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.comment.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 18,
                      color: widget.comment.isLiked
                          ? Colors.red
                          : AppColors.iconGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.comment.likeCount.toString(),
                      style: TextStyle(
                        color: AppColors.iconGrey,
                        fontSize: AppFontSize.f12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '0',
                style: TextStyle(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f12,
                ),
              ),

              const SizedBox(width: 20),

              // Reply toggle
              GestureDetector(
                onTap: () => setState(() => _showReplyField = !_showReplyField),
                child: Text(
                  _showReplyField ? 'Cancel' : 'Reply',
                  style: const TextStyle(
                    color: AppColors.cyanColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),

              if (widget.comment.replies.isNotEmpty) ...[
                const SizedBox(width: 16),
                Text(
                  '${widget.comment.replies.length} '
                  '${widget.comment.replies.length == 1 ? 'reply' : 'replies'}',
                  style: TextStyle(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f12,
                  ),
                ),
              ],
            ],
          ),

          // ── Reply input ───────────────────────────────────────────
          if (_showReplyField) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _replyController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Write a reply...',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _handleAddReply,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cyanColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.send, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],

          // ── Recursive replies — indented ──────────────────────────
          if (widget.comment.replies.isNotEmpty) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: widget.comment.replies
                    .map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CommentCard(
                          comment: reply,
                          postId: widget.postId,
                        ),
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
}
