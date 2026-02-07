class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final String category;
  final String readTime;
  final DateTime publishDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.category,
    required this.readTime,
    required this.publishDate,
  });
}
