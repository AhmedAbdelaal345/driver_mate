import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class MyNavigation {
  static void navigateTo(Widget screen, {dynamic arguments}) {
    Get.to(screen, transition: Transition.leftToRight, arguments: arguments);
  }

  static void navigateBack() {
    Get.back();
  }
}
