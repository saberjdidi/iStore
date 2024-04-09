import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/services/firebase_storage_service.dart';
import 'package:i_store/features/shop/models/brand_category_model.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/format_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';

///Repository class for managing category-related data and operations
class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return list;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get SubCategories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db.collection("Categories").where('ParentId', isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong when getting SubCategories. Please try again';
    }
  }

  ///Upload Categories to the Cloud Firebase
  Future<void> uploadDummyCategoriesData(List<CategoryModel> categories) async {
    try {
      //Upload all the categories along with their images
      final storage = Get.put(FirebaseStorageService());

      //Loop through each category
      for (var category in categories){
        //Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        //Upload Image and get its URL
        final url = await storage.uploadImageData('Categories', file, category.name);

        //Assign URL to image of category attribute
        category.image = url;

        //Store Category in FireStore
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Upload Brands-Categories to the Cloud Firebase
  Future<void> uploadDummyBrandsCategoriesData(List<BrandCategoryModel> list) async {
    try {
      //Loop through each item
      for (var item in list){
        //Store BrandCategory in FireStore
        await _db.collection("BrandCategory").add(item.toJson());
      }
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}