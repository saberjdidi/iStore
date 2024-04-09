class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues
  });

  ///Static function to create an empty user model
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {});

  ///Convert model to json structure for storing data in firebase
  toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  ///Factory method  from a Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if(data.isEmpty) return ProductVariationModel.empty();

    //Map json Record to the model
    return ProductVariationModel(
          id: data['Id'] ?? '',
          price: double.parse((data['Price'] ?? 0.0).toString()),
          salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
          sku: data['SKU'] ?? '',
          stock: data['Stock'] ?? 0,
          image: data['Image'] ?? '',
          attributeValues:  Map<String, String>.from(data['AttributeValues']),
    );
  }
}