import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productId;
  final String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  ///Static function to create an empty user model
  static ProductCategoryModel empty() => ProductCategoryModel(categoryId: '', productId: '');

  ///Convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    //Map json Record to the model
    return ProductCategoryModel(
        productId: data['productId'] as String,
        categoryId: data['categoryId'] as String
    );
  }

}