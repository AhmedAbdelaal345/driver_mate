import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class MyNavigation {
  static void navigateTo(Widget screen) {
    Get.to(screen, transition: Transition.leftToRight);
  }
  static void navigateBack() {
    Get.back();
  }
}
