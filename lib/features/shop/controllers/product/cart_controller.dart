import 'package:get/get.dart';
import 'package:i_store/features/shop/controllers/product/variation_controller.dart';
import 'package:i_store/features/shop/models/cart_item_model.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/enums.dart';
import 'package:i_store/utils/local_storage/storage_utility.dart';
import 'package:i_store/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  ///Variables
 RxInt noOfCartItems = 0.obs;
 RxInt productQuantityInCart = 0.obs;
 RxDouble totalCartPrice = 0.0.obs;
 RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
 final variationController = VariationController.instance;

 CartController() {
   loadCartItems();
 }

 //Add items in the cart
 addToCart(ProductModel product){
   //Quantity check
   if(productQuantityInCart.value < 1){
     TLoaders.customToast(message: 'Select Quantity');
     return;
   }

   //Variation selected
   if(product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty){
     TLoaders.customToast(message: 'Select Variation');
     return;
   }

   //Out of stock status
   if(product.productType == ProductType.variable.toString()){
     if(variationController.selectedVariation.value.stock < 1){
        TLoaders.warningSnackBar(title: 'Selected variation is out of stock', message: 'Oh snap!');
        return;
     }
   }
   else {
       if(product.stock < 1){
         TLoaders.warningSnackBar(title: 'Selected product is out of stock', message: 'Oh snap!');
         return;
       }
   }

   //Convert the ProductModel to a CartItemModel with the given quantity
   final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);

   //Check if already added in the cart
   int index = cartItems.indexWhere((cartItem) => cartItem.productId == selectedCartItem.productId && cartItem.variationId == selectedCartItem.variationId);

   if(index >= 0){
     //This quantity is already added or updated/removed from the design (cart)
     cartItems[index].quantity = selectedCartItem.quantity;
   } else {
     cartItems.add(selectedCartItem);
   }

   updateCart();
   TLoaders.customToast(message: 'Your Product has been added to the Cart.');
 }

 addOneToCart(CartItemModel item){
   int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

   if(index >= 0){
     cartItems[index].quantity += 1;
   } else {
     cartItems.add(item);
   }

   updateCart();
 }

 removeOneFromCart(CartItemModel item){
   int index = cartItems.indexWhere((cartItem) => cartItem.productId == item.productId && cartItem.variationId == item.variationId);

   if(index >= 0){
     if(cartItems[index].quantity > 1){
       cartItems[index].quantity -= 1;
     }
     else {
       //Show dialog before remove
       cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
     }
     updateCart();
   }
 }

  removeFromCartDialog(int index){
    Get.defaultDialog(
        title: 'Remove Product',
        middleText: 'Are you sure to remove this product?',
        onConfirm: (){
          cartItems.removeAt(index);
          updateCart();
          TLoaders.customToast(message: 'Product removed from the Cart.');
          Get.back();
        },
      onCancel: (){
          Get.back();
      }
    );
  }

  ///-- Initialize already added Item's count in the cart
  updateAlreadyAddedProductCount(ProductModel product){
   //if product has no variations then calculate cartEntries and display total number
    //else make default entries to 0 and show cartEntries when variation is selected
    if(product.productType == ProductType.single.toString()){
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    }
    else {
      //Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      }
      else {
        productQuantityInCart.value = 0;
      }
    }
  }

 ///Convert ProductModel to CartItemModel
 CartItemModel convertToCartItem(ProductModel product, int quantity){
   if(product.productType == ProductType.single.toString()){
    //Reset variation in case of single product type
     variationController.resetSelectedAttributes();
   }

   final variation = variationController.selectedVariation.value;
   final isVariation = variation.id.isNotEmpty;
   final price = isVariation
       ? variation.salePrice > 0.0
         ? variation.salePrice
         : variation.price
       : product.salePrice > 0.0
         ? product.salePrice
         : product.price;

   return CartItemModel(
     productId: product.id,
     title: product.title,
     price: price,
     image: isVariation ? variation.image : product.thumbnail,
     quantity: quantity,
     variationId: variation.id,
     brandName: product.brand != null ? product.brand!.name : '',
     selectedVariation: isVariation ? variation.attributeValues : null,
   );
 }

 ///Update Cart values
  updateCart(){
   updateCartTotals();
   saveCartItems();
   cartItems.refresh();
  }

  updateCartTotals(){
   double calculatedTotalPrice = 0.0;
   int calculateNoOfItems = 0;

   for(var item in cartItems){
     calculatedTotalPrice += (item.price) * item.quantity.toDouble();
     calculateNoOfItems += item.quantity;
   }

   totalCartPrice.value = calculatedTotalPrice;
   noOfCartItems.value = calculateNoOfItems;
  }

  saveCartItems() {
   final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
   TLocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  loadCartItems() {
    final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if(cartItemStrings != null){
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId){
   final foundItem = cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
   return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId){
    final foundItem = cartItems.firstWhere((item) =>
    item.productId == productId && item.variationId == variationId,
    orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  clearCart() {
   productQuantityInCart.value = 0;
   cartItems.clear();
   updateCart();
  }

}