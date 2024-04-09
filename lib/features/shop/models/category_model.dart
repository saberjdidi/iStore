import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_store/utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  String parentId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = ''
  });

  ///Static function to create an empty user model
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);

  ///Convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ParentId': parentId
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      final data = document.data()!;

      //Map json Record to the model
      return CategoryModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          parentId: data['ParentId'] ?? '',
          isFeatured: data['IsFeatured'] ?? false
      );
    }
    else {
      return CategoryModel.empty();
    }
  }


}