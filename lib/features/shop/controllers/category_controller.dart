import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/categories/category_repository.dart';
import 'package:i_store/data/repositories/product/product_repository.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());

  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load Categories data
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final categories = await categoryRepository.getAllCategories();

      for (var element in categories) {
        debugPrint('category element : ${element.name} - ${element.image}');
      }

      //Update the categories list
      allCategories.assignAll(categories);

      //Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

      //isLoading.value = false;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }

 /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await categoryRepository.getSubCategories(categoryId);
      return subCategories;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

 /// -- Get Category Products
  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}