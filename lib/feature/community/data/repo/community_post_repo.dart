import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';
import 'package:driver_mate/feature/community/data/model/community_create_post_model.dart';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';

abstract class CommunityPostRepository {
  Future<Either<String, List<CommunityFetchPostModel>>> fetchPosts({
    required int page,
    required int limit,
  });
  Future<Either<String, ApiResponse>> createPost({
    required String type,
    required String title,
    required String description,
    File? imageFile,
  });
  Future<Either<String, String>> deletePost(String postId);
  Future<Either<String, LikeModel>> likeComment({required String postId});
}

class InMemoryCommunityPostRepository implements CommunityPostRepository {
  final List<CommunityFetchPostModel> _posts = [
    CommunityFetchPostModel(
      id: 'seed-1',
      postType: 0,
      commentCount: 0,
      isLikedByCurrentUser: false,
      likeCount: 0,
      isSaved: false,
      authorImageUrl: AppImagePath.profilePersonIconPath,
      imagesCount: 2,
      title: 'Strange clicking sound when turning',
      content:
          'My car makes a clicking noise when I turn the steering wheel. It only happens at low speeds.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)).toString(),
      authorName: 'Ahmed Hassan',
      imageUrls: [AppImagePath.bmwCarImagePath, AppImagePath.bmwCarImagePath],
    ),
    CommunityFetchPostModel(
      id: 'seed-2',
      postType: 1,
      commentCount: 0,
      isLikedByCurrentUser: false,
      likeCount: 0,
      isSaved: false,
      authorImageUrl: AppImagePath.profilePersonIconPath,
      imagesCount: 2,
      title: 'Best oil change interval for city driving',
      content:
          'I recommend changing oil every 5,000 km if you drive mostly in heavy traffic.',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)).toString(),
      authorName: 'Sara Ali',
    ),
  ];

  @override
  Future<Either<String, List<CommunityFetchPostModel>>> fetchPosts({
    required int page,
    required int limit,
  }) async {
    try {
      ApiResponse response = await ApiHelper().getRequest(
        endpoint: "community",
        isAuthorized: true,
        queryParameters: {"pageNumber": page, "pageSize": limit},
      );

      if (response.statusCode != 200) {
        return left(
          "fetchPosts failed [${response.statusCode}]: ${response.message}",
        );
      }

      // response.data is body["data"], which the backend sends as a List.
      final rawList = response.data;
      if (rawList == null) {
        return left("fetchPosts: response.data is null");
      }
      if (rawList is! List) {
        return left(
          "fetchPosts: expected List but got ${rawList.runtimeType}. "
          "Raw value: $rawList",
        );
      }

      final posts = <CommunityFetchPostModel>[];
      for (int i = 0; i < rawList.length; i++) {
        try {
          posts.add(
            CommunityFetchPostModel.fromJson(
              rawList[i] as Map<String, dynamic>,
            ),
          );
          print(
            "\n \n \n the post sent images are :${posts.last.imageUrls}\n \n \n",
          );
        } catch (parseError) {
          // Surface exactly which item and which field broke.
          return left(
            "fetchPosts: failed to parse item[$i]: $parseError\n"
            "Raw item: ${rawList[i]}",
          );
        }
      }

      _posts
        ..clear()
        ..addAll(posts);

      return Right(List.unmodifiable(_posts));
    } catch (e, stack) {
      // Rethrow-style: surface the REAL error so nothing is silently swallowed.
      return left("fetchPosts unexpected error: $e\n$stack");
    }
  }

  @override
  Future<Either<String, String>> deletePost(String postId) async {
    try {
      ApiResponse response = await ApiHelper().deleteRequest(
        endpoint: "community/$postId",
        isAuthorized: true,
      );
      if (response.statusCode != 200) {
        return left(
          "The problem occurred deleting the post: ${response.message}",
        );
      }
      fetchPosts(page: 1, limit: 10);
      _posts.removeWhere((e) => e.id == postId);
      return Right("Post deleted successfully");
    } catch (e) {
      return left("There is an Error occured when processing your request");
    }
  }

  @override
  Future<Either<String, ApiResponse>> createPost({
    required String type,
    required String title,
    required String description,
    File? imageFile,
  }) async {
    final now = DateTime.now();
    try {
      print("========================");
      print(imageFile);
      print(imageFile?.path);
      print(imageFile?.existsSync());

      final body = CommunityCreatePostModel(
        title: title,
        content: description,
        postType: type,
        imagePost: imageFile,
      ).toJson();

      print(body);

      final ApiResponse response = await ApiHelper().postRequest(
        endpoint: "community",
        isAuthorized: true,
        isForm: true,
        data:await CommunityCreatePostModel(
          title: title,
          content: description,
          postType: type,
          imagePost: imageFile,
        ).toJson(),
      );

      final post = CommunityFetchPostModel(
        id: 'post-${now.microsecondsSinceEpoch}',
        postType: 0,
        commentCount: 0,
        isLikedByCurrentUser: false,
        likeCount: 0,
        isSaved: false,
        authorImageUrl: AppImagePath.profilePersonIconPath,
        imagesCount: 2,
        title: title,
        content: description,
        createdAt: now.toString(),
        authorName: 'User',
        imageUrls: [imageFile.toString()],
      );
      _posts.insert(0, post);

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(
          "The problem occurred creating the post: ${response.message}",
        );
      }
    } catch (e) {
      return left("The problem occurred creating the post:${e.toString()}");
    }
  }

  @override
  Future<Either<String, LikeModel>> likeComment({
    required String postId,
  }) async {
    try {
      ApiResponse response = await ApiHelper().postRequest(
        endpoint: "Community/$postId/like",
        isAuthorized: true,
        isForm: false,
      );
      if (response.statusCode != 200) {
        return left("There is an Error occured when processing your request");
      }
      final result = LikeModel.fromJson(json: response.data);
      return Right(result);
    } catch (e) {
      return left("There is an Error occured when processing your request");
    }
  }
}
