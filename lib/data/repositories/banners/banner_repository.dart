import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/services/firebase_storage_service.dart';
import 'package:i_store/features/shop/models/banner_model.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Get all Banners related to current User
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection("Banners").where('Active', isEqualTo: true).get();
      return result.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong while fetching banners.';
    }
  }

 ///Upload Banners to Cloud Firebase
  Future<void> uploadBannersDummyData(List<BannerModel> banners) async {
    try {
      //Upload all the categories along with their images
      final storage = Get.put(FirebaseStorageService());

      //Loop through each category
      for (var banner in banners){
        //Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        //Upload Image and get its URL
        final url = await storage.uploadImageData('Banners', file, banner.targetScreen);

        //Assign URL to image of category attribute
        banner.imageUrl = url;

        //Store Category in FireStore
        await _db.collection("Banners").add(banner.toJson());
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