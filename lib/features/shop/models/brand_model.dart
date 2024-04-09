import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  ///Static function to create an empty user model
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  ///Convert model to json structure for storing data in firebase
  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  ///map json oriented document snapshot from Firebase to Model
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return BrandModel.empty();

      //Map json Record to the model
      return BrandModel(
          id: data['Id'] ?? '',
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
          productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
      );
  }

  ///map json oriented document snapshot from Firebase to Model
  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {

    if(document.data() != null){
      final data = document.data()!;

      //Map json Record to the model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
      );
    }
    else {
      return BrandModel.empty();
    }

  }

}