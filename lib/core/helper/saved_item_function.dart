import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void savedItemFunction(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String image,
  required SavedType type,
  required bool isSaved,
  String? readTime,
  String? year,
  String? rating,
  String? price,
  String? distance,
  int? comments,
  int? likes,
}) {
  final cubit = context.read<SavedItemCubit>();
  final item = SavedItemModel(
    title: title,
    subtitle: subtitle,
    image: image,
    type: type,
    readTime: readTime,
    year: year,
    rating: rating,
    price: price,
    distance: distance,
    comments: comments,
    likes: likes,
  );
  if (isSaved) {
    cubit.removeItem(item);

    AppNotifier.show(
      context,
      "Item removed from saved",
      type: NotifierType.error,
    );
  } else {
    cubit.addItem(item);

    AppNotifier.show(
      context,
      "Item saved successfully",
      type: NotifierType.success,
    );
  }
}
