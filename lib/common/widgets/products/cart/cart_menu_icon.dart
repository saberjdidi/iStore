import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:i_store/features/shop/controllers/product/cart_controller.dart';
import 'package:i_store/features/shop/screens/cart/cart_screen.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    this.iconColor = TColors.black,
  });

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    //Get an instance of CartController
    final controller = Get.put(CartController());

    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
                child: Obx(() => Text(
                    controller.noOfCartItems.value.toString(),
                    style:Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontSizeFactor: 0.8)
                ))
            ),
          ),
        )
      ],
    );
  }
}