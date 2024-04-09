import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/brands/brand_repository.dart';
import 'package:i_store/data/repositories/product/product_repository.dart';
import 'package:i_store/features/shop/models/brand_model.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final brandRepository = Get.put(BrandRepository());
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  ///Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      for (var element in brands) {
        debugPrint('category element : ${element.name} - ${element.image}');
      }

      //Update the brands list
      allBrands.assignAll(brands);

      //Filter featured Brands
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4).toList());

      //isLoading.value = false;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }

  ///Get Brands for Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  ///Get Brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}