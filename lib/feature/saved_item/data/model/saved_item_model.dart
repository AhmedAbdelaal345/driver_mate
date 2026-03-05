import 'dart:convert';

enum SavedType { car, service, article, post }

class SavedItemModel {
  final String title;
  final String subtitle;
  final String image;
  final SavedType type;
  final String? rating; // for Service → "4.8"
  final String? distance; // for Service → "2.5 km"
  final int? likes; // for Post    → 42
  final int? comments; // for Post    → 15
  final String? readTime; // for Article → "5 min read"
  final String? year; // for Car     → "2023"
  final String? price; // for Car     → "SAR 285,000"
  SavedItemModel({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.type,
    this.rating,
    this.distance,
    this.likes,
    this.comments,
    this.readTime,
    this.year,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "subtitle": subtitle,
      "image": image,
      "type": type.name,
      "rating": rating,
      "distance": distance,
      "likes": likes,
      "comments": comments,
      "readTime": readTime,
      "year": year,
      "price": price,
    };
  }

  factory SavedItemModel.fromMap(Map<String, dynamic> map) {
    return SavedItemModel(
      title: map["title"],
      subtitle: map["subtitle"],
      image: map["image"],
      type: SavedType.values.firstWhere((e) => e.name == map["type"]),
      rating: map["rating"],
      distance: map["distance"],
      likes: map["likes"],
      comments: map["comments"],
      readTime: map["readTime"],
      year: map["year"],
      price: map["price"],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SavedItemModel.fromJson(String source) =>
      SavedItemModel.fromMap(jsonDecode(source));
}
