import 'package:driver_mate/feature/community/data/model/community_post.dart';

abstract class CommunityPostState {
  const CommunityPostState(this.posts);
  final List<CommunityPost> posts;
}

class CommunityPostInitial extends CommunityPostState {
  const CommunityPostInitial() : super(const []);
}

class CommunityPostLoading extends CommunityPostState {
  const CommunityPostLoading(List<CommunityPost> posts) : super(posts);
}

class CommunityPostLoaded extends CommunityPostState {
  const CommunityPostLoaded(List<CommunityPost> posts) : super(posts);
}

class CommunityPostSuccess extends CommunityPostState {
  const CommunityPostSuccess(List<CommunityPost> posts, this.message)
      : super(posts);
  final String message;
}

class CommunityPostFailure extends CommunityPostState {
  const CommunityPostFailure(List<CommunityPost> posts, this.error)
      : super(posts);
  final String error;
}
