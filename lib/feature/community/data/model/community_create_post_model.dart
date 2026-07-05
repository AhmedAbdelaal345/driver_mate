import 'dart:io';

import 'package:driver_mate/core/local/api_keys.dart';

class CommunityCreatePostModel {
  final String title;
  final String content;
  final String postType;
  final File? imagePost;

  CommunityCreatePostModel({
    required this.title,
    required this.content,
    required this.postType,
    this.imagePost,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKeys.title: title,
      ApiKeys.content: content,
      ApiKeys.postType: postType,
      ApiKeys.images: imagePost,
    };
  }
}
