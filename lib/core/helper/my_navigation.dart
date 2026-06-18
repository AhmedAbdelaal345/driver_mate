import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MyNavigation {
  static Future<dynamic> navigateTo(Widget screen, {dynamic arguments}) async {
    return Get.to(
      () => screen,

      transition: Transition.rightToLeft,

      arguments: arguments,

      preventDuplicates: false,
    );
  }

  static Future<dynamic> navigateOff(Widget screen, {dynamic arguments}) async {
    return Get.off(
      () => screen,

      transition: Transition.leftToRight,

      arguments: arguments,
    );
  }

  static Future<void> navigateBack() async {
    if (Get.isOverlaysOpen) {
      Get.back();

      return;
    }

    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    }
  }
}
