import 'package:get/get.dart';
import 'package:i_store/features/personalization/controllers/address_controller.dart';
import 'package:i_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:i_store/features/shop/controllers/product/variation_controller.dart';
import 'package:i_store/utils/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }

}