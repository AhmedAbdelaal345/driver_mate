/// postType from the API is an int (enum on the backend), not a String.
enum CommunityPostType { question, tip, review, marketplace, problem, unknown }

CommunityPostType communityPostTypeFromInt(int value) {
  switch (value) {
    case 0:
      return CommunityPostType.question;
    case 1:
      return CommunityPostType.problem;
    case 2:
      return CommunityPostType.tip;
    case 3:
      return CommunityPostType.review;
    case 4:
      return CommunityPostType.marketplace;
    default:
      return CommunityPostType.unknown;
  }
}

class CommunityFetchPostModel {
  final String id;
  final String title;
  final String content;
  final int postType;
  final String authorName;
  final String createdAt;
  final int imagesCount;
  final List<String> imageUrls;
  final String? authorImageUrl;
  bool? isSaved;

  // ✅ NOT final — cubit mutates these for optimistic like updates
  int likeCount;
  bool isLikedByCurrentUser;
  int commentCount;

  CommunityFetchPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.postType,
    required this.authorName,
    required this.createdAt,
    required this.imagesCount,
    required this.likeCount,
    required this.commentCount,
    required this.isLikedByCurrentUser,
    List<String>? imageUrls,
    this.authorImageUrl,
    this.isSaved = false,
  }) : imageUrls = imageUrls ?? [];

  String? get firstImageUrl => imageUrls.isEmpty ? null : imageUrls.first;

  String get authorInitials {
    final trimmed = authorName.trim();
    if (trimmed.isEmpty) return '?';
    if (trimmed.length == 1) return trimmed.toUpperCase();
    return trimmed.substring(0, 2).toUpperCase();
  }

  factory CommunityFetchPostModel.fromJson(Map<String, dynamic> json) {
    return CommunityFetchPostModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      postType: (json['postType'] as num?)?.toInt() ?? 0,
      authorName: json['authorName']?.toString() ?? 'Unknown',
      createdAt:
          json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
      imagesCount: (json['imagesCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool? ?? false,
      imageUrls:
          (json['imageUrls'] as List?)?.whereType<String>().toList() ?? [],
      authorImageUrl: json['authorImageUrl']?.toString(),
    );
  }

  CommunityFetchPostModel copyWith({
    int? likeCount,
    bool? isLikedByCurrentUser,
    int? commentCount,
  }) {
    return CommunityFetchPostModel(
      id: id,
      title: title,
      content: content,
      postType: postType,
      authorName: authorName,
      createdAt: createdAt,
      imagesCount: imagesCount,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLikedByCurrentUser: isLikedByCurrentUser ?? this.isLikedByCurrentUser,
      imageUrls: imageUrls,
      authorImageUrl: authorImageUrl,
      isSaved: isSaved,
    );
  }
}

class LikeToggleResult {
  final int likeCount;
  final bool isLikedByCurrentUser;

  LikeToggleResult({
    required this.likeCount,
    required this.isLikedByCurrentUser,
  });

  factory LikeToggleResult.fromJson(Map<String, dynamic> json) {
    return LikeToggleResult(
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool? ?? false,
    );
  }
}
