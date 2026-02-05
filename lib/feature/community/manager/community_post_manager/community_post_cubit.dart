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
      final posts = await repo.fetchPosts();
      emit(CommunityPostLoaded(posts));
    } catch (e) {
      emit(CommunityPostFailure(state.posts, e.toString()));
    }
  }

  Future<void> createPost({
    required String type,
    required String title,
    required String description,
  }) async {
    emit(CommunityPostLoading(state.posts));
    try {
      final CommunityPostModel post = await repo.createPost(
        type: type,
        title: title,
        description: description,
      );
      final updated = [post, ...state.posts];
      emit(CommunityPostSuccess(updated, 'Post published'));
      emit(CommunityPostLoaded(updated));
    } catch (e) {
      emit(CommunityPostFailure(state.posts, e.toString()));
    }
  }
}
