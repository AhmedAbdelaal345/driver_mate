import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver_mate/core/local/api_keys.dart';

class CommunityCreatePostModel {
  final String title;
  final String content;
  final int postType;
  final File? imagePost;

  CommunityCreatePostModel({
    required this.title,
    required this.content,
    required this.postType,
    this.imagePost,
  });

  Future<Map<String, dynamic>> toJson() async {
    return {
      ApiKeys.title: title,
      ApiKeys.content: content,
      ApiKeys.postType: postType,
      if (imagePost != null)
        ApiKeys.images: await MultipartFile.fromFile(
          imagePost!.path,
          filename: imagePost!.path.split('/').last,
        ),
    };
  }
}
