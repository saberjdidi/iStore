import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/features/personalization/models/user_model.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/format_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';
import 'package:image_picker/image_picker.dart';


///Repository class for user-related operations
class UserRepository extends GetxController {
 static UserRepository get instance => Get.find();

 final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Save User data to FireStore
  Future<void> saveUserRecord(UserModel user) async {
   try {
     await _db.collection("Users").doc(user.id).set(user.toJson());
   }
   on FirebaseException catch (e){
    throw TFirebaseException(e.code).message;
   }
   on FormatException catch (_){
    throw const TFormatException();
   }
   on PlatformException catch (e){
    throw TPlatformException(e.code).message;
   }
   catch (e) {
    throw 'Something went wrong. Please try again';
   }
  }

 ///Fetch user details based on user id
 Future<UserModel> fetchUserDetails() async {
  try {
   final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
   if (documentSnapshot.exists){
     return UserModel.fromSnapshot(documentSnapshot);
   }
   else {
    return UserModel.empty();
   }
  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 }

 ///Update user data in Firestore
 Future<void> updateUserDetails(UserModel updatedUser) async {
  try {
   await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());

  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 }

 ///Update any field in specific Users collection
 Future<void> updateSingleField(Map<String, dynamic> json) async {
  try {
   await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 }

 ///Remove user data from Firestore.
 Future<void> removeUserRecord(String userId) async {
  try {
   await _db.collection("Users").doc(userId).delete();
  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 }

 ///Upload Image using file_picker
 ///import 'package:file_picker/file_picker.dart';
 /*Future<String> uploadImage(String path, PlatformFile image) async {
  try {
   final ref = FirebaseStorage.instance.ref(path).child(image.name);
   //await ref.putFile(File(image.path));
   await ref.putData(image.bytes!);
   final url = await ref.getDownloadURL();
   return url;
  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 } */

 ///Upload Image using image_picker
 Future<String> uploadImage(String path, XFile image) async {
  try {
   final ref = FirebaseStorage.instance.ref(path).child(image.name);
   await ref.putFile(File(image.path));
   final url = await ref.getDownloadURL();
   return url;
  }
  on FirebaseException catch (e){
   throw TFirebaseException(e.code).message;
  }
  on FormatException catch (_){
   throw const TFormatException();
  }
  on PlatformException catch (e){
   throw TPlatformException(e.code).message;
  }
  catch (e) {
   throw 'Something went wrong. Please try again';
  }
 }

}