class CarItem {
  final String image;
  final String title;
  final double price;
  final String location;
  final String category;
  final String subtitle;
  final String details;
  final bool isNew;

  const CarItem({
    required this.image,
    required this.title,
    required this.price,
    required this.location,
    required this.category,
    required this.subtitle,
    required this.details,
    this.isNew = false,
  });
}

class ServiceCenterItem {
  final String name;
  final double distanceKm;
  final double rating;

  const ServiceCenterItem({
    required this.name,
    required this.distanceKm,
    required this.rating,
  });
}

class TipItem {
  final String image;
  final String category;
  final String readTime;
  final String title;
  final String excerpt;

  const TipItem({
    required this.image,
    required this.category,
    required this.readTime,
    required this.title,
    required this.excerpt,
  });
}
