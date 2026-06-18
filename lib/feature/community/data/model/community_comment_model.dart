class CommunityCommentModel {
  final String commentId;
  final String postId;
  final String authorName;
  final String authorInitials;
  String content;
  final DateTime createdAt;
  int numberOfLikes;
  bool isLiked;
  int likesCount;
  int commentsCount;

  // Non-nullable — always a list, never null
  List<CommunityCommentModel> replies;

  CommunityCommentModel({
    required this.commentId,
    required this.postId,
    required this.authorName,
    required this.authorInitials,
    required this.content,
    required this.createdAt,
    required this.numberOfLikes,
    this.isLiked = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    List<CommunityCommentModel>? replies, // optional in constructor
  }) : replies = replies ?? []; // ← always defaults to empty list
}
