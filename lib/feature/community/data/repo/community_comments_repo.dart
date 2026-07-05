import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';

class CommunityCommentsRepo {
  CommunityCommentsRepo._instance();
  static final CommunityCommentsRepo _singelTone =
      CommunityCommentsRepo._instance();
  factory CommunityCommentsRepo() => _singelTone;

  /// Fetches the FLAT list of comments/replies for a post. Nesting is not
  /// done here — the cubit groups by parentCommentId.
  Future<List<CommunityGetCommentModel>> getCommentsForPost(
    String postId,
  ) async {
    try {
      final response = await ApiHelper().getRequest(
        endpoint: 'Community/$postId/comments',
        isAuthorized: true,
        isForm: false,
      );
      if (response.statusCode != 200) {
        throw Exception(response.message.isNotEmpty ? response.message : "Failed to load comments");
      }
      final data = response.data as List<dynamic>;
      // ✅ removed: no longer appending the hardcoded mock `comments` list
      // onto every real API response
      return data
          .map((e) => CommunityGetCommentModel.fromJson(json: e))
          .toList();
    } catch (e) {
      print('getCommentsForPost error: $e');
      rethrow;
    }
  }

  /// Replies for a single comment, derived by filtering the flat list on
  /// parentCommentId == commentId.
  Future<List<CommunityGetCommentModel>> getRepliesForComment({
    required String commentId,
    required String postId,
  }) async {
    try {
      final ApiResponse response = await ApiHelper().getRequest(
        endpoint: 'Community/$postId/comments',
        isAuthorized: true,
        isForm: false,
      );
      if (response.statusCode != 200) {
        throw Exception(response.message.isNotEmpty ? response.message : "Failed to load replies");
      }
      final data = response.data as List<dynamic>;
      // ✅ map to models FIRST, then filter — previously filtered raw
      // Map<String,dynamic> objects for a `.parentCommentId` getter that
      // doesn't exist on a Map, which threw on every call
      final comments = data
          .map((e) => CommunityGetCommentModel.fromJson(json: e))
          .toList();
      return comments.where((c) => c.parentCommentId == commentId).toList();
    } catch (e) {
      print('getRepliesForComment error: $e');
      rethrow;
    }
  }

  Future<void> addCommentToPost({
    required String postId,
    required String content,
    String? parentCommentId,
  }) async {
    try {
      final response = await ApiHelper().postRequest(
        endpoint: 'Community/$postId/comments',
        isAuthorized: true,
        isForm: false,
        data: CommunityAddCommentModel(
          content: content,
          postId: postId,
          parentCommentId: parentCommentId,
        ).toJson(),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.message.isNotEmpty ? response.message : "Failed to add comment");
      }
    } catch (e) {
      print('addCommentToPost error: $e');
      rethrow;
    }
  }

  /// ✅ A reply IS a comment with parentCommentId set — this now just calls
  /// the same endpoint as addCommentToPost, passing parentCommentId. It was
  /// previously synchronous, never hit the network, and mutated a broken
  /// `late final` field.
  Future<void> addReplyToComment({
    required String postId,
    required String commentId,
    required String content,
  }) async {
    await addCommentToPost(
      postId: postId,
      content: content,
      parentCommentId: commentId,
    );
  }

  Future<void> removeReply({
    required String postId,
    required String replyId,
  }) async {
    try {
      final response = await ApiHelper().deleteRequest(
        endpoint: 'Community/$postId/comments/$replyId',
        isAuthorized: true,
      );
      if (response.statusCode != 200) {
        throw Exception(response.message.isNotEmpty ? response.message : "Failed to remove reply");
      }
    } catch (e) {
      print('removeReply error: $e');
      rethrow;
    }
  }

  // Future<Either<String, LikeModel>> likeComment(
  //   String commentId,
  //   String postId,
  // ) async {
  //   try {
  //     final response = await ApiHelper().postRequest(
  //       endpoint: 'api/community/$postId/like',
  //       isAuthorized: true,
  //       isForm: false,
  //     );
  //     if (response.statusCode != 200) {
  //       return left('There is an Error occured when processing your request');
  //     }
  //     return Right(LikeModel.fromJson(json: response.data));
  //   } catch (e) {
  //     return left('There is an Error occured when processing your request');
  //   }
  // }
}
