import 'dart:io';

class CommunityPostModel {
  final String id;
  final String title;
  final String description;
  final String authorName;
  final String authorInitials;
  final DateTime createdAt;
  final String type;

  // Asset image (bundled in app) — used for seed/mock data
  final String? imageAssetPath;

  // File image (picked by user from gallery/camera)
  final File? imageFile;

  bool isLiked;
  bool isSaved;
  int likesCount;
  int commentsCount;

  CommunityPostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.authorInitials,
    required this.createdAt,
    required this.type,
    this.imageAssetPath,
    this.imageFile,
    this.isLiked = false,
    this.isSaved = false,
    this.likesCount = 0,
    this.commentsCount = 0,
  });
}