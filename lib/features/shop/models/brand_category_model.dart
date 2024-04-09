import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  final String brandId;
  final String categoryId;

  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  ///Static function to create an empty user model
  static BrandCategoryModel empty() => BrandCategoryModel(categoryId: '', brandId: '');

  ///Convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'categoryId': categoryId
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    //Map json Record to the model
    return BrandCategoryModel(
      brandId: data['brandId'] as String,
      categoryId: data['categoryId'] as String
    );
  }

}