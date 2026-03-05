import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';

SavedType getSavedType(String category) {
  switch (category.toLowerCase()) {
    case "car":
      return SavedType.car;
    case "service":
      return SavedType.service;
    case "article":
      return SavedType.article;
    case "post":
      return SavedType.post;
    default:
      return SavedType.article;
  }
}