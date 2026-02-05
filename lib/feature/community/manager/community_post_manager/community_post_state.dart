import 'package:driver_mate/feature/community/data/model/community_post_model.dart';

abstract class CommunityPostState {
  const CommunityPostState(this.posts);
  final List<CommunityPostModel> posts;
}

class CommunityPostInitial extends CommunityPostState {
  const CommunityPostInitial() : super(const  []);
}

class CommunityPostLoading extends CommunityPostState {
  const CommunityPostLoading(super.posts);
}

class CommunityPostLoaded extends CommunityPostState {
  const CommunityPostLoaded(super.posts);
}

class CommunityPostSuccess extends CommunityPostState {
  const CommunityPostSuccess(super.posts, this.message);
  final String message;
}

class CommunityPostFailure extends CommunityPostState {
  const CommunityPostFailure(super.posts, this.error);
  final String error;
}
