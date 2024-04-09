import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/brands/brand_show_case.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical_static.dart';
import 'package:i_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/controllers/category_controller.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/screens/all_products/all_products.dart';
import 'package:i_store/features/shop/screens/store/widgets/category_brands.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Brands
                ///Dynamic Data
                CategoryBrands(category: category,),
                ///Static Data
                //const TBrandShowcase(images: [TImages.productImage3, TImages.productImage2, TImages.productImage1],),
                const SizedBox(height: TSizes.spaceBtwItems),

                ///Products
                FutureBuilder(
                    future: controller.getCategoryProducts(categoryId : category.id),
                    builder: (context, snapshot){
                      final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const TVerticalProductShimmer());

                      //Return appropriate widget based on snapshot state
                      if(widget != null) return widget;

                      final products = snapshot.data!;
                      return Column(
                        children: [
                          TSectionHeading(
                              title: 'You might like',
                              onPressed: () => Get.to(() => AllProductsScreen(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(categoryId: category.id, limit: -1),
                            ))
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          ///Dynamic Data
                          TGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) =>  TProductCardVertical(product: products[index])
                          ),
                        ],
                      );
                    }
                )

                ///Static Data
                //TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVerticalStatic()),
              ],
            )),
      ],
    );
  }
}
