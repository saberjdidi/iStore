import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/common/widgets/success_screen.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/data/repositories/order/order_repository.dart';
import 'package:i_store/features/personalization/controllers/address_controller.dart';
import 'package:i_store/features/shop/controllers/product/cart_controller.dart';
import 'package:i_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:i_store/features/shop/models/order_model.dart';
import 'package:i_store/features/shop/screens/home/home_screen.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/enums.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  ///Variables
 final cartController = CartController.instance;
 final addressController = AddressController.instance;
 final checkoutController = CheckoutController.instance;
 final orderRepository = Get.put(OrderRepository());

 ///fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    }
    catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  ///Add methods for order processing
  processOrder(double totalAmount) async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your order...', TImages.pencilAnimation);

      //Get user authentication id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) return;

      //Add details
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      //save the order to firestore
      await orderRepository.saveOrder(order, userId);

      //Update the cart status
      cartController.clearCart();

      Get.off(() => SuccessScreen(
          image: TImages.orderCompletedAnimation,
          title: 'Payment success!',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(()=> const NavigationMenuWidget())
      ));

    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}