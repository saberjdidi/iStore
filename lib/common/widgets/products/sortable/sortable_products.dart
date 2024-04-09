import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical_static.dart';
import 'package:i_store/features/shop/controllers/product/all_products_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key, required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing product sorting
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);

    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value){
            //Sort products based on the selected option
            controller.sortProducts(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e)
          ))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections,),

        ///Products
        //TGridLayout(itemCount: 8, itemBuilder: (_, index) => const TProductCardVerticalStatic()),
        Obx(() => TGridLayout(itemCount: controller.products.length, itemBuilder: (_, index) => TProductCardVertical(product: controller.products[index]))),
      ],
    );
  }
}