
class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
     this.name,
    this.values
  });

  ///Convert model to json structure for storing data in firebase
  toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  ///Factory method  from a Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
      final data = document;

      if(data.isEmpty) return ProductAttributeModel();

      //Map json Record to the model
      return ProductAttributeModel(
          name: data.containsKey('Name') ? data['Name'] : '',
          values: List<String>.from(data['Values'])
      );
  }
}