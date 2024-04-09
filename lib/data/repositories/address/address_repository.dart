import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/features/personalization/models/address_model.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  ///Get User Addresses
  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Enable to find user information. Try again in few minutes.';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((e) => AddressModel.fromDocumentSnapshot(e)).toList();
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong while fetching Address.';
    }
  }

  ///Clear the selected field for all address
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Enable to find user information. Try again in few minutes.';
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Enable to update your Address selection';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      //if(userId.isEmpty) throw 'Enable to find user information. Try again in few minutes.';
     final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
     return currentAddress.id;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong while saving Address in FireStore.';
    }
  }
}