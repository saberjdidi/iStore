import 'package:get/get.dart';
import 'package:i_store/features/shop/controllers/product/cart_controller.dart';
import 'package:i_store/features/shop/controllers/product/images_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  ///Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  ///Select Attribute and Variation
  void onAttributeSelected(ProductModel product, attributeName, attributeValue){
    //When attribute is selected we will first add that attribute to the selected attribute
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
            (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
    orElse: () => ProductVariationModel.empty());

    //Show the selected Variation image as a Main Image
    if(selectedVariation.image.isNotEmpty){
      ImagesController.instance.selectedProductImages.value = selectedVariation.image;
    }

    //Show selected variation quantity already in the cart
    if(selectedVariation.id.isNotEmpty){
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    //Assign selected variation
    this.selectedVariation.value = selectedVariation;

    //Update selected product variation status
    getProductVariationStockStatus();
  }

  ///check if selected attributes matches any variation attributes
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes){
   //if selectedAttributes contains 3 attributes and current variation contains 2 then return
    if(variationAttributes.length != selectedAttributes.length) return false;

    //if any of the attributes is different then return. e.g. [Green, Large] x [Green, Small]
    for(final key in variationAttributes.keys){
      //Attribute[Key] = Value which could be [Green, Small, Cotton] etc.
      if(variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  ///Check attribute availability / Stock in variation
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName){
    //Pass the variations to check which attributes are available and stock in not 0
    final availableVariationAttributeValues = variations.where((variation) =>
    //Check empty / out of stock Attributes
      variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
    .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice(){
    return (selectedVariation.value.salePrice > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  ///Check product variation stock status
  void getProductVariationStockStatus(){
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  ///Reset selected attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();

  }
}