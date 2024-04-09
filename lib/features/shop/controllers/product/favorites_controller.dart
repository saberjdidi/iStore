import 'dart:convert';

import 'package:get/get.dart';
import 'package:i_store/data/repositories/product/product_repository.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/local_storage/storage_utility.dart';
import 'package:i_store/utils/popups/loaders.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  ///Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  ///Reading Favorites from Storage
  Future<void> initFavorites() async {
   final json = TLocalStorage.instance().readData('favorites');
   if(json != null){
     final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
     favorites.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
   }
  }

  bool isFavourite(String productId){
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if(!favorites.containsKey(productId)){
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Product has been added to the Wishlist');
    }
    else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(message: 'Product has been removed from the Wishlist');
    }
  }

  void saveFavoritesToStorage(){
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(favorites.keys.toList());
  }
}