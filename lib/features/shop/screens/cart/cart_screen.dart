import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/loaders/animation_loader.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/features/shop/controllers/product/cart_controller.dart';
import 'package:i_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:i_store/features/shop/screens/checkout/checkout_screen.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = CartController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Obx((){
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Cart is Empty',
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenuWidget()),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              ///Items in cart
              child: TCartItems(),
            ),
          );
        }
      }),

      ///Checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
        ? const SizedBox()
        : Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Obx(() => Text('Checkout \$${controller.totalCartPrice.value}')),
          ),
        ),
    );
  }
}
