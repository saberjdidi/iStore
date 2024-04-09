import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/icons/t_circular_icon.dart';
import 'package:i_store/features/shop/controllers/product/favorites_controller.dart';
import 'package:iconsax/iconsax.dart';

class TFavoriteIcon extends StatelessWidget {
  const TFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(() => TCircularIcon(
        icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
    ));
  }
}
