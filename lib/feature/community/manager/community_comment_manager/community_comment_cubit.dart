import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';
import 'package:driver_mate/feature/community/data/repo/community_comments_repo.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCommentCubit extends Cubit<CommunityCommentState> {
  CommunityCommentCubit() : super(CommunityCommentInitial());

  final CommunityCommentsRepo _repo = CommunityCommentsRepo();

  // Single source of truth — never re-fetch after mutations
  final List<CommunityCommentModel> _comments = [];

  // ── Fetch (only called once on page open) ─────────────────────────────────
  Future<void> fetchCommentsForPost(String postId) async {
    emit(CommunityCommentLoading());
    try {
      final fetched = await _repo.getCommentsForPost(postId);
      _comments
        ..clear()
        ..addAll(fetched);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  // ── Add comment (optimistic: update local list, no re-fetch) ──────────────
 void addComment(String postId, String content) {
    try {
      final newComment = CommunityCommentModel(
        commentId: 'comment-${DateTime.now().millisecondsSinceEpoch}',
        postId: postId,
        authorName: 'Current User',
        authorInitials: 'CU',
        content: content,
        createdAt: DateTime.now(),
        numberOfLikes: 0,
      );

      // ❌ remove: _repo.addCommentToPost(postId, content);
      _comments.add(newComment);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  void likeComment(String postId, String commentId) {
    try {
      final target = _findComment(_comments, commentId);
      if (target == null) return;

      target.isLiked = !target.isLiked;
      target.numberOfLikes += target.isLiked ? 1 : -1;

      // ❌ remove: _repo.likeComment(commentId);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  void addReply(String postId, String commentId, String content) {
    try {
      final parent = _findComment(_comments, commentId);
      if (parent == null) return;

      parent.replies.add(
        CommunityCommentModel(
          commentId:
              '$commentId-reply-${DateTime.now().millisecondsSinceEpoch}',
          postId: postId,
          authorName: 'Current User',
          authorInitials: 'CU',
          content: content,
          createdAt: DateTime.now(),
          numberOfLikes: 0,
        ),
      );

      // ❌ remove: _repo.addReplyToComment(postId, commentId, content);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  void removeReply(String postId, String commentId, String replyId) {
    try {
      final parent = _findComment(_comments, commentId);
      if (parent == null) return;

      parent.replies.removeWhere((r) => r.commentId == replyId);

      // ❌ remove: _repo.removeReply(commentId, replyId);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  void editReply(
    String postId,
    String commentId,
    String replyId,
    String newContent,
  ) {
    try {
      final target = _findComment(_comments, replyId);
      if (target == null) return;

      target.content = newContent;

      // ❌ remove: _repo.editReplay(commentId, replyId, newContent);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }
  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Recursively finds a comment/reply by ID at any nesting depth
  CommunityCommentModel? _findComment(
    List<CommunityCommentModel> list,
    String id,
  ) {
    for (final comment in list) {
      if (comment.commentId == id) return comment;
      if (comment.replies.isNotEmpty) {
        final found = _findComment(comment.replies, id);
        if (found != null) return found;
      }
    }
    return null;
  }

  /// Emits a shallow-copied list so BlocBuilder always detects the change
  void _emitLoaded() {
    emit(CommunityCommentLoaded(comments: List.from(_comments)));
  }
}
