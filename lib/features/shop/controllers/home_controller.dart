import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:i_store/utils/pref_utils.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  /// Update Current Index When Page Scroll
  void updatePageIndicator(index) => carouselCurrentIndex.value = index;

  final isBoarding = PrefUtils.getIsBoarding();

  @override
  void onInit() {
    super.onInit();

    debugPrint('isBoarding : $isBoarding');
  }
}