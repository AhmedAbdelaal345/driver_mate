import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';
import 'package:driver_mate/feature/community/data/repo/community_comments_repo.dart';
import 'package:driver_mate/feature/community/manager/community_comment_manager/community_comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityCommentCubit extends Cubit<CommunityCommentState> {
  CommunityCommentCubit() : super(CommunityCommentInitial());

  final CommunityCommentsRepo _repo = CommunityCommentsRepo();

  // ✅ Flat list is the single source of truth — matches how the API
  // actually models replies (parentCommentId, not nesting). The tree is
  // rebuilt from this flat list every time we emit.
  final List<CommunityGetCommentModel> _comments = [];

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

  // ✅ Now actually calls the repo/API instead of only touching local state.
  // Previously the network call was commented out, so anything added here
  // vanished the next time fetchCommentsForPost ran.
  Future<void> addComment(String postId, String content) async {
    try {
      await _repo.addCommentToPost(postId: postId, content: content);
      _comments.add(
        CommunityGetCommentModel(
          commentId: 'comment-${DateTime.now().millisecondsSinceEpoch}',
          postId: postId,
          authorName: 'Current User',
          content: content,
          createdAt: DateTime.now(),
          parentCommentId: null,
        ),
      );
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  Future<void> addReply(String postId, String commentId, String content) async {
    // Guard against replying to a comment that isn't in the flat list.
    final parentExists = _comments.any((c) => c.commentId == commentId);
    if (!parentExists) return;

    try {
      await _repo.addReplyToComment(
        postId: postId,
        commentId: commentId,
        content: content,
      );
      _comments.add(
        CommunityGetCommentModel(
          commentId:
              '$commentId-reply-${DateTime.now().millisecondsSinceEpoch}',
          postId: postId,
          authorName: 'Current User',
          content: content,
          parentCommentId: commentId, // ✅ this is what makes it a reply
          createdAt: DateTime.now(),
        ),
      );
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  Future<void> removeReply(String postId, String replyId) async {
    try {
      await _repo.removeReply(postId: postId, replyId: replyId);
      _comments.removeWhere((c) => c.commentId == replyId);
      _emitLoaded();
    } catch (e) {
      emit(CommunityCommentError(e.toString()));
    }
  }

  void likeComment(String postId, String commentId) {
    // ✅ Purely local UI toggle — comments are never liked through the API.
    final target = _findFlat(commentId);
    if (target == null) return;

    target.isLiked = !target.isLiked;
    target.likeCount += target.isLiked ? 1 : -1;

    _emitLoaded();
  }

  // Finds a comment/reply in the flat source-of-truth list by id.
  CommunityGetCommentModel? _findFlat(String commentId) {
    for (final c in _comments) {
      if (c.commentId == commentId) return c;
    }
    return null;
  }
  // ── Tree building ──────────────────────────────────────────────────────
  // The API gives us a flat list where each comment/reply carries
  // parentCommentId. A top-level comment has parentCommentId == null; a
  // reply's parentCommentId points at the commentId it replies to (and a
  // reply-to-a-reply just chains further). We rebuild the nested structure
  // from that flat list on every emit, rather than mutating objects that
  // came back from a previous build.

  List<CommunityGetCommentModel> _buildTree() {
    final topLevel = _comments.where((c) => c.parentCommentId == null).toList();
    for (final comment in topLevel) {
      comment.replies
        ..clear()
        ..addAll(_repliesOf(comment.commentId));
    }
    return topLevel;
  }

  List<CommunityGetCommentModel> _repliesOf(String parentId) {
    final children = _comments
        .where((c) => c.parentCommentId == parentId)
        .toList();
    for (final child in children) {
      child.replies
        ..clear()
        ..addAll(_repliesOf(child.commentId));
    }
    return children;
  }

  void _emitLoaded() {
    emit(CommunityCommentLoaded(comments: _buildTree()));
  }
}
