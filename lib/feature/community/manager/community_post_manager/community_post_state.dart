import 'package:driver_mate/feature/community/data/model/community_post.dart';

abstract class CommunityPostState {
  const CommunityPostState(this.posts);
  final List<CommunityPostModel> posts;
}

class CommunityPostInitial extends CommunityPostState {
  const CommunityPostInitial() : super(const []);
}

class CommunityPostLoading extends CommunityPostState {
  const CommunityPostLoading(List<CommunityPostModel> posts) : super(posts);
}

class CommunityPostLoaded extends CommunityPostState {
  const CommunityPostLoaded(List<CommunityPostModel> posts) : super(posts);
}

class CommunityPostSuccess extends CommunityPostState {
  const CommunityPostSuccess(List<CommunityPostModel> posts, this.message)
    : super(posts);
  final String message;
}

class CommunityPostFailure extends CommunityPostState {
  const CommunityPostFailure(List<CommunityPostModel> posts, this.error)
    : super(posts);
  final String error;
}
