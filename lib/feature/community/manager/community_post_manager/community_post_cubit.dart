import 'dart:io';
import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';
import 'package:driver_mate/feature/community/data/model/community_post_model.dart';
import 'package:driver_mate/feature/community/data/repo/community_post_repo.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPostCubit extends Cubit<CommunityPostState> {
  CommunityPostCubit({required this.repo})
    : super(const CommunityPostInitial());

  final CommunityPostRepository repo;

  Future<void> loadPosts() async {
    emit(CommunityPostLoading(state.posts));
    try {
      final posts = await repo.fetchPosts(limit: 10, page: 1);
      posts.fold(
        (l) {
          emit(CommunityPostFailure(state.posts, l.toString()));
        },
        (r) {
          emit(CommunityPostLoaded(r));
        },
      );
    } catch (e) {
      emit(CommunityPostFailure(state.posts, e.toString()));
    }
  }

  Future<void> createPost({
    required String type,
    required String title,
    required String description,
    File? image,
  }) async {
    emit(CommunityPostLoading(state.posts));
    try {
      final post = await repo.createPost(
        type: type,
        title: title,
        description: description,
        imageFile: image,
      );
      post.fold(
        (l) {
          emit(CommunityPostFailure(state.posts, l.toString()));
        },
        (r)async {
          emit(
            CommunityCreatePostSuccess(
              state.posts,
              message: r.message.toString(),
            ),
          );
          await loadPosts();
        },
      );
    } catch (e) {
      emit(CommunityPostFailure(state.posts, e.toString()));
    }
  }

  Future<void> toggleLike({required String postId}) async {
    CommunityFetchPostModel? target;

    for (final p in state.posts) {
      if (p.id == postId) {
        target = p;
        break;
      }
    }

    if (target == null) return;

    final previousLiked = target.isLikedByCurrentUser;
    final previousCount = target.likeCount;
    target.isLikedByCurrentUser = !target.isLikedByCurrentUser;
    target.likeCount += target.isLikedByCurrentUser ? 1 : -1;
    emit(CommunityPostLoaded(List.from(state.posts)));

    try {
      final res = await repo.likeComment(postId: postId);
      res.fold(
        (l) {
          target!.isLikedByCurrentUser = previousLiked;
          target.likeCount = previousCount;
          emit(
            CommunityPostFailure(
              List.from(state.posts),
              l.toString(),
              postId: postId,
            ),
          );
        },
        (r) {
          target!.isLikedByCurrentUser = r.isLiked;
          target.likeCount = r.numberOfLikes;
          emit(
            CommunityLikeToggleSuccess(
              List.from(state.posts),
              postId,
              r.numberOfLikes,
              r.isLiked,
            ),
          );
        },
      );
    } catch (e) {
      target.isLikedByCurrentUser = previousLiked;
      target.likeCount = previousCount;
      emit(
        CommunityPostFailure(
          List.from(state.posts),
          e.toString(),
          postId: postId,
        ),
      );
    }
  }
}
