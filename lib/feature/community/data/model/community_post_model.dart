class CommunityPostModel {
  const CommunityPostModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.authorName,
    required this.authorInitials,
  });

  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime createdAt;
  final String authorName;
  final String authorInitials;

  CommunityPostModel copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    DateTime? createdAt,
    String? authorName,
    String? authorInitials,
  }) {
    return CommunityPostModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      authorName: authorName ?? this.authorName,
      authorInitials: authorInitials ?? this.authorInitials,
    );
  }
}
