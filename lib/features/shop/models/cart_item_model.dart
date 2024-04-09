import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    this.title = '',
    this.price = 0.0,
     this.image,
    required this.quantity,
    this.variationId = '',
    this.brandName,
    this.selectedVariation,
  });

  ///Static function to create an empty user model
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  ///Convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  ///map json oriented document snapshot from Firebase to Model
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    //if(json.isEmpty) return CartItemModel.empty();

    ///Map json Record to the model
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null ? Map<String, String>.from(json['selectedVariation']) : null,
    );
  }

  ///map json oriented document snapshot from Firebase to Model
  factory CartItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {

    if(document.data() != null){
      final data = document.data()!;

      //Map json Record to the model
      return CartItemModel(
        productId: document.id,
        title: data['title'] ?? '',
        price: data['price'] ?? 0.0,
        image: data['image'] ?? '',
        quantity: data['quantity'] ?? 0,
        variationId: data['variationId'] ?? '',
        brandName: data['brandName'] ?? '',
        selectedVariation: data['selectedVariation'] ?? '',
      );
    }
    else {
      return CartItemModel.empty();
    }

  }

}