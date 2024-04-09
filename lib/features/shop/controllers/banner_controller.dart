import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/banners/banner_repository.dart';
import 'package:i_store/features/shop/models/banner_model.dart';
import 'package:i_store/utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  ///Variables
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> bannersList = <BannerModel>[].obs;

  //ctr + O
  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update Page Navigational Dots
  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  ///Fetch Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      //Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final result = await bannerRepo.fetchBanners();

      for (var element in result) {
        debugPrint('Banner element : ${element.targetScreen} - ${element.imageUrl}');
      }

      bannersList.assignAll(result);

    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }
}