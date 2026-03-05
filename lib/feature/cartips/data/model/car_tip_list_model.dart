class CarTipListModel {
  final String title;
  final String description;
  final String category;
  final int minutes;
  final bool isUpdated;
  final String image;

  const CarTipListModel({
    required this.title,
    required this.description,
    required this.category,
    required this.minutes,
    required this.isUpdated,
    required this.image,
  });

  factory CarTipListModel.fromJson(Map<String, dynamic> json) =>
      CarTipListModel(
        title: json['title'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        isUpdated: json['isUpdated'],
        minutes: json['json'],
      );
}
