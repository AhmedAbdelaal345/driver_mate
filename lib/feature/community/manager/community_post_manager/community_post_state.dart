import 'package:driver_mate/feature/community/data/model/community_fetch_post_model.dart';

abstract class CommunityPostState {
  const CommunityPostState(this.posts);
  final List<CommunityFetchPostModel> posts;
}

class CommunityPostInitial extends CommunityPostState {
  const CommunityPostInitial() : super(const []);
}

class CommunityPostLoading extends CommunityPostState {
  const CommunityPostLoading(super.posts);
}

class CommunityPostLoadingMore extends CommunityPostState {
  const CommunityPostLoadingMore(super.posts);
}

class CommunityPostLoaded extends CommunityPostState {
  const CommunityPostLoaded(super.posts, {this.hasMore = true});
  final bool hasMore;
}

class CommunityCreatePostSuccess extends CommunityPostState {
  const CommunityCreatePostSuccess(super.posts, {required this.message});
  final String message;
}

class CommunityLikeToggleSuccess extends CommunityPostState {
  const CommunityLikeToggleSuccess(
    super.posts,
    this.postId,
    this.numberoflikes,
    this.isLiked,
  );
  final String postId;
  final int numberoflikes;
  final bool isLiked;
}

class CommunityPostFailure extends CommunityPostState {
  const CommunityPostFailure(super.posts, this.error, {this.postId});
  final String error;
  final String? postId;
}
