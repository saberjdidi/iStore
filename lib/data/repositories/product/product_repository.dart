import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/services/firebase_storage_service.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/enums.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';

///Repository class for managing product-related data and operations
class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Get limited featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection("Products").where('IsFeatured', isEqualTo: true).limit(6).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db.collection("Products").where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get products based on the brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get Products by BrandId
  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db.collection("Products").where('Brand.Id', isEqualTo: brandId).get()
          : await _db.collection("Products").where('Brand.Id', isEqualTo: brandId).limit(limit).get();
      final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get Products by BrandId
  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = 4}) async {
    try {
      //Query to get all Documents where categoryId matches the provided categoryId
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db.collection("ProductCategory").where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection("ProductCategory").where('categoryId', isEqualTo: categoryId).limit(limit).get();

      //Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      //Query to get all documents where the productId is in the list productIds, FieldPath.documentId to query documents in Collection
      final productsQuery = await _db.collection("Products").where(FieldPath.documentId, whereIn: productIds).get();

      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Get Favorites Products
  Future<List<ProductModel>> getFavoriteProducts(List<String> productIds) async {
    try {
      final snapshot = await _db.collection("Products").where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
    }
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      //Upload all the categories along with their images
      final storage = Get.put(FirebaseStorageService());

      //Loop through each category
      for (var product in products){
        //Get ImageData link from the local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);

        //Upload Image and get its URL
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        //Assign URL to product.thumbnail attribute
        product.thumbnail = url;

        //Product list of images
        if(product.images != null && product.images!.isNotEmpty){
           List<String> imagesUrl = [];
           for (var image in product.images!){
             //Get image data link from local assets
             final assetImage = await storage.getImageDataFromAssets(image);

             //Upload image and get it's URL
             final url = await storage.uploadImageData('Products/Images', assetImage, image);

             //Assign URL to product.images attribute
             imagesUrl.add(url);
           }
           product.images!.clear();
           product.images!.addAll(imagesUrl);
        }

        //Upload Variation images
        if(product.productType == ProductType.variable.toString()){
          for (var variation in product.productVariations!){
            //Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);

            //Upload image and get it's URL
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            //Assign URL to variation.image attribute
           variation.image = url;
          }
        }

        //Store product in FireStore
        await _db.collection("Products").doc(product.id).set(product.toJson());
      }
    }
    on FirebaseException catch (e){
      throw e.message!;
    }
    on SocketException catch (e){
      throw e.message;
    }
    on PlatformException catch (e){
      throw e.message!;
    }
    catch (e) {
      throw e.toString();
    }
  }
}