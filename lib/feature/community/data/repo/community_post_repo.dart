import 'package:driver_mate/feature/community/data/model/community_post.dart';

abstract class CommunityPostRepository {
  Future<List<CommunityPostModel>> fetchPosts();
  Future<CommunityPostModel> createPost({
    required String type,
    required String title,
    required String description,
  });
}

class InMemoryCommunityPostRepository implements CommunityPostRepository {
  final List<CommunityPostModel> _posts = [
    CommunityPostModel(
      id: 'seed-1',
      type: 'Question',
      title: 'Strange clicking sound when turning',
      description:
          'My car makes a clicking noise when I turn the steering wheel. It only happens at low speeds.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      authorName: 'Ahmed Hassan',
      authorInitials: 'AH',
    ),
    CommunityPostModel(
      id: 'seed-2',
      type: 'Tips',
      title: 'Best oil change interval for city driving',
      description:
          'I recommend changing oil every 5,000 km if you drive mostly in heavy traffic to maintain engine health.',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      authorName: 'Sara Ali',
      authorInitials: 'SA',
    ),
  ];

  @override
  Future<List<CommunityPostModel>> fetchPosts() async {
    return List<CommunityPostModel>.from(_posts);
  }

  @override
  Future<CommunityPostModel> createPost({
    required String type,
    required String title,
    required String description,
  }) async {
    final now = DateTime.now();
    final post = CommunityPostModel(
      id: 'post-${now.microsecondsSinceEpoch}',
      type: type,
      title: title,
      description: description,
      createdAt: now,
      authorName: 'User',
      authorInitials: 'US',
    );
    _posts.insert(0, post);
    return post;
  }
}
