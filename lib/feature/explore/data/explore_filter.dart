class ExploreFilter {
  final String category; // "All" / "Cars" / "Maintenance" / "Tips"
  final String sortBy; // "Recommended" / "Newest" / "Nearest" / "Price: Low to High" / "Price: High to Low"
  final bool useMyLocation;
  final double minPrice;
  final double maxPrice;
  final double maxDistanceKm;
  final double minRating;

  const ExploreFilter({
    this.category = "All",
    this.sortBy = "Recommended",
    this.useMyLocation = true,
    this.minPrice = 0,
    this.maxPrice = 100000,
    this.maxDistanceKm = 50,
    this.minRating = 0,
  });

  ExploreFilter copyWith({
    String? category,
    String? sortBy,
    bool? useMyLocation,
    double? minPrice,
    double? maxPrice,
    double? maxDistanceKm,
    double? minRating,
  }) {
    return ExploreFilter(
      category: category ?? this.category,
      sortBy: sortBy ?? this.sortBy,
      useMyLocation: useMyLocation ?? this.useMyLocation,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      minRating: minRating ?? this.minRating,
    );
  }

  static const ExploreFilter initial = ExploreFilter();
}


