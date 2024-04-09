import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/services/firebase_storage_service.dart';
import 'package:i_store/features/shop/models/brand_model.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/format_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';

///Repository class for managing brand-related data and operations
class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  ///Variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Get all Brands
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (e){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong while fetching Brands';
    }
  }

  ///Get Brands of Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      //Query to get all Documents where categoryId matches the provided categoryId
      QuerySnapshot brandCategoryQuery = await _db.collection("BrandCategory").where("categoryId", isEqualTo: categoryId).get();

      //Extract BrandsIds from the documents
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      //Query to get all documents where the brandId is in the list brandIds, FieldPath.documentId to query documents in Collection
      final brandsQuery = await _db.collection("Brands").where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<BrandModel> brands = brandsQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();

      return brands;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (e){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong while fetching Brands';
    }
  }

  ///Upload Categories to the Cloud Firebase
  Future<void> uploadBrandsDummyData(List<BrandModel> brands) async {
    try {
      //Upload all the categories along with their images
      final storage = Get.put(FirebaseStorageService());

      //Loop through each brand
      for (var brand in brands){
        //Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(brand.image);

        //Upload Image and get its URL
        final url = await storage.uploadImageData('Brands', file, brand.name);

        //Assign URL to image of category attribute
        brand.image = url;

        //Store Category in FireStore
        await _db.collection("Brands").doc(brand.id).set(brand.toJson());
      }
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong when uploading Brands';
    }
  }

}