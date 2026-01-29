class ExploreFilter {
  final String category; // "All" / "Cars" / "Maintenance" / "Tips"
  final double minPrice;
  final double maxPrice;
  final double maxDistanceKm;
  final double minRating;

  const ExploreFilter({
    this.category = "All",
    this.minPrice = 0,
    this.maxPrice = 100000,
    this.maxDistanceKm = 50,
    this.minRating = 0,
  });

  ExploreFilter copyWith({
    String? category,
    double? minPrice,
    double? maxPrice,
    double? maxDistanceKm,
    double? minRating,
  }) {
    return ExploreFilter(
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      minRating: minRating ?? this.minRating,
    );
  }

  static const ExploreFilter initial = ExploreFilter();
}


