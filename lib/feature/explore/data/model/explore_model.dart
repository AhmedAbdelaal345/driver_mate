class CarItem {
  final String image;
  final String title;
  final double price; // رقم للفلترة
  final String location;
  final String category; // مثال: Cars, Electric...

  const CarItem({
    required this.image,
    required this.title,
    required this.price,
    required this.location,
    required this.category,
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

