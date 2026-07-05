import 'package:driver_mate/feature/community/data/model/community_comment_model.dart';

abstract class CommunityCommentState {}

class CommunityCommentInitial extends CommunityCommentState {}

class CommunityCommentLoading extends CommunityCommentState {}

class CommunityCommentLoaded extends CommunityCommentState {
  final List<CommunityGetCommentModel> comments;

  CommunityCommentLoaded({required this.comments});
}

class CommunityCommentError extends CommunityCommentState {
  final String message;

  CommunityCommentError(this.message);
}