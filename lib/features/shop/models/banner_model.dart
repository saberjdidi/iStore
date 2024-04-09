import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.targetScreen,
    required this.imageUrl,
    required this.active,
  });

  ///Static function to create an empty user model
  static BannerModel empty() => BannerModel(targetScreen: '', imageUrl: '', active: false);

  ///Convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  ///Factory method to create a UserModel from a Firebase document snapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      //Map json Record to the model
      return BannerModel(
          imageUrl: data['ImageUrl'] ?? '',
          targetScreen: data['TargetScreen'] ?? '',
          active: data['Active'] ?? false,
      );
  }

}