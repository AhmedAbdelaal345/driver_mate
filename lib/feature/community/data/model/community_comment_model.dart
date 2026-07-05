import 'package:driver_mate/core/local/api_keys.dart';

class CommunityAddCommentModel {
  final String content;
  final String postId;
  final String? parentCommentId;

  CommunityAddCommentModel({
    required this.content,
    required this.postId,
    this.parentCommentId,
  });

  Map<String, dynamic> toJson() {
    return {ApiKeys.content: content, ApiKeys.parentCommentId: parentCommentId};
  }
}

class LikeModel {
  final bool isLiked;
  final int numberOfLikes;

  LikeModel({required this.isLiked, required this.numberOfLikes});

  factory LikeModel.fromJson({required Map<String, dynamic> json}) {
    return LikeModel(
      // ✅ guarded casts — was an unguarded implicit cast before, threw on
      // a missing/null key instead of degrading gracefully
      isLiked: json[ApiKeys.isLikedByCurrentUser] as bool? ?? false,
      numberOfLikes: (json[ApiKeys.likeCount] as num?)?.toInt() ?? 0,
    );
  }
}

class CommunityGetCommentModel {
  final String commentId;
  final String authorName;
  final String postId;
  final String content;
  final String? parentCommentId;
  final DateTime createdAt;
  final List<CommunityGetCommentModel> replies;

  // ✅ UI-only state — toggled locally, never sent to/read from the API.
  bool isLiked;
  int likeCount;

  CommunityGetCommentModel({
    required this.commentId,
    required this.authorName,
    required this.postId,
    required this.content,
    required this.parentCommentId,
    required this.createdAt,
    List<CommunityGetCommentModel>? replies,
    this.isLiked = false,
    this.likeCount = 0,
  }) : replies = replies ?? [];

  factory CommunityGetCommentModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return CommunityGetCommentModel(
      commentId: json[ApiKeys.id],
      authorName: json[ApiKeys.authorName],
      postId: json[ApiKeys.postId],
      content: json[ApiKeys.content],
      parentCommentId: json[ApiKeys.parentCommentId],
      createdAt: DateTime.parse(json[ApiKeys.createdAt] as String),
      // isLiked/likeCount intentionally NOT parsed from json — comment
      // likes don't come from or go to the backend.
    );
  }
}
