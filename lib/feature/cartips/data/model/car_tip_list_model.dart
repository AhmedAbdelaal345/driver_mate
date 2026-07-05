import 'package:driver_mate/core/local/api_keys.dart';

class CarTipListModel {
  final String id;
  final String title;
  final String content;
  final String? category;
  final String authorName;
  final String imageUrl;
  final DateTime createdAt;

  const CarTipListModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.authorName,
    required this.imageUrl,
    required this.createdAt,
  });

  factory CarTipListModel.fromJson(Map<String, dynamic> json) {
    return CarTipListModel(
      id: json[ApiKeys.id] as String,
      title: json[ApiKeys.title] as String,
      content: json[ApiKeys.content] as String,
      category: json[ApiKeys.category] as String?,
      authorName: json[ApiKeys.authorName] as String,
      imageUrl: json[ApiKeys.imageUrl] as String,
      createdAt: DateTime.parse(json[ApiKeys.createdAt]),
    );
  }

 
}
