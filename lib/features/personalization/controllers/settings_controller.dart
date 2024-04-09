import 'package:get/get.dart';
import 'package:i_store/data/repositories/banners/banner_repository.dart';
import 'package:i_store/data/repositories/brands/brand_repository.dart';
import 'package:i_store/data/repositories/categories/category_repository.dart';
import 'package:i_store/data/repositories/product/product_repository.dart';
import 'package:i_store/data/services/dummy_data.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());
  final bannerRepository = Get.put(BannerRepository());
  final productRepository = Get.put(ProductRepository());
  final brandRepository = Get.put(BrandRepository());

  uploadDataOfCategories() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Your Categories are uploading...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update first & last Name in Firestore
      await categoryRepository.uploadDummyCategoriesData(TDummyData.categories);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Successfully', message: 'Data uploaded.');
    }
    catch (e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadDataOfBanners() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Your Banners are uploading...', TImages.uploadingAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update first & last Name in Firestore
      await bannerRepository.uploadBannersDummyData(TDummyData.banners);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Successfully', message: 'Data uploaded.');
    }
    catch (e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadDataOfBrands() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Your Brands are uploading...', TImages.uploadingAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update first & last Name in Firestore
      await brandRepository.uploadBrandsDummyData(TDummyData.brands);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Successfully', message: 'Data uploaded.');
    }
    catch (e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadDataOfProducts() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Your Products are uploading...', TImages.uploadingAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update first & last Name in Firestore
      await productRepository.uploadDummyData(TDummyData.products);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Successfully', message: 'Data uploaded.');
    }
    catch (e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadDataOfBrandsCategories() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Your BrandCategory are uploading...', TImages.uploadingAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Update first & last Name in Firestore
      await categoryRepository.uploadDummyBrandsCategoriesData(TDummyData.brandCategory);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show success message
      TLoaders.successSnackBar(title: 'Successfully', message: 'Data uploaded.');
    }
    catch (e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}