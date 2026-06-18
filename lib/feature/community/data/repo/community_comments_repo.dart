import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';

class CommunityCommentsRepo {
  // Private constructor to prevent external instantiation
  CommunityCommentsRepo._instance();
  static final CommunityCommentsRepo _singelTone =
      CommunityCommentsRepo._instance();
  factory CommunityCommentsRepo() => _singelTone;

  List<CommunityCommentModel> comments = [
    CommunityCommentModel(
      commentId: 'comment-1',
      numberOfLikes: 0,
      postId: 'post-1',
      authorName: 'John Doe',
      authorInitials: 'JD',
      content: 'This is a comment on post 1.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      replies: [
        CommunityCommentModel(
          commentId: 'comment-1-reply-1',
          postId: 'post-1',
          authorName: 'Jane Smith',
          authorInitials: 'JS',
          content: 'This is a reply to comment 1.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          numberOfLikes: 0,
          // no replies needed — defaults to []
        ),
      ],
    ),
    CommunityCommentModel(
      commentId: 'comment-2',
      postId: 'post-1',
      authorName: 'Jane Smith',
      authorInitials: 'JS',
      content: 'This is another comment on post 1.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      numberOfLikes: 0,
      // replies defaults to [] automatically
    ),
    CommunityCommentModel(
      commentId: 'comment-3',
      postId: 'post-2',
      authorName: 'Alice Johnson',
      authorInitials: 'AJ',
      content: 'This is a comment on post 2.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      numberOfLikes: 0,
    ),
  ];
  Future<List<CommunityCommentModel>> getCommentsForPost(String postId) async {
    // Return a list of comments for the given post ID
    return comments.where((comment) => comment.postId == postId).toList();
  }

  Future<List<CommunityCommentModel>> getRepliesForComment(
    String commentId,
  ) async {
    // Find the comment with the given ID and return its replies
    final comment = comments.firstWhere((c) => c.commentId == commentId);
    return comment.replies;
  }

  void addCommentToPost(String postId, String comment) {
    // Simulate adding a comment to the post
    comments.add(
      CommunityCommentModel(
        commentId: 'comment-${comments.length + 1}',
        postId: postId,
        authorName: 'Current User',
        authorInitials: 'CU',
        content: comment,
        createdAt: DateTime.now(),
        numberOfLikes: 0,
      ),
    );
    print("Added comment to post $postId: $comment");
  }

  void addReplyToComment(String postId, String commentId, String reply) {
    // Simulate adding a reply to a comment
    final comment = comments.firstWhere((c) => c.commentId == commentId);

    comment.replies.add(
      CommunityCommentModel(
        commentId: '$commentId-reply-${comment.replies.length + 1}',
        postId: postId,
        authorName: 'Current User',
        authorInitials: 'CU',
        content: reply,
        createdAt: DateTime.now(),
        numberOfLikes: 0,
      ),
    );
    print("Added reply to comment $commentId on post $postId: $reply");
  }

  void removeReply(String commentId, String replyId) {
    // Simulate removing a comment
    final comment = comments.firstWhere((c) => c.commentId == commentId);

    comment.replies.removeWhere((reply) => reply.commentId == replyId);

    print("Removed reply with ID: $replyId");
  }

  void editReplay(String commentId, String replyId, String newContent) {
    // Simulate editing a comment
    final comment = comments.firstWhere((c) => c.commentId == commentId);
    final reply = comment.replies.firstWhere((r) => r.commentId == replyId);
    reply.content = newContent;
    print("Edited reply with ID: $replyId. New content: $newContent");
  }

  void likeComment(String commentId) {
    // Simulate liking a comment
    final comment = comments.firstWhere((c) => c.commentId == commentId);
    comment.numberOfLikes++;
    print(
      "Liked comment with ID: $commentId. Total likes: ${comment.numberOfLikes}",
    );
  }

  void likeReply(String commentId, String replyId) {
    // Simulate liking a reply
    final comment = comments.firstWhere((c) => c.commentId == commentId);
    final reply = comment.replies.firstWhere((r) => r.commentId == replyId);
    reply.numberOfLikes++;
    print("Liked reply with ID: $replyId. Total likes: ${reply.numberOfLikes}");
  }

  // ── Recursive finder used by all repo methods ──────────────────────────
  CommunityCommentModel? _findComment(
    List<CommunityCommentModel> list,
    String id,
  ) {
    for (final c in list) {
      if (c.commentId == id) return c;
      final found = _findComment(c.replies, id);
      if (found != null) return found;
    }
    return null;
  }
}
