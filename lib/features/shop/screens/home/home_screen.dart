import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical_static.dart';
import 'package:i_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/controllers/product/product_controller.dart';
import 'package:i_store/features/shop/screens/all_products/all_products.dart';
import 'package:i_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:i_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:i_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///AppBar
                  THomeAppBar(),
                   SizedBox(height: TSizes.spaceBtwSections,),

                  ///SerachBar
                   TSearchContainer(text: 'Search in Store',),
                   SizedBox(height: TSizes.spaceBtwSections,),

                  ///Categories
                  Padding(
                    padding:  EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                         TSectionHeading(title: 'Popular Categories', showActionButton: false, textColor: TColors.white,),
                         SizedBox(height: TSizes.spaceBtwItems,),
                         THomeCategories()
                      ],
                    ),
                  ),
                   SizedBox(height: TSizes.spaceBtwSections),
                ],
              )
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Promo Slider
                  const TPromoSlider(banners: [TImages.promoBanner1, TImages.promoBanner2, TImages.promoBanner3],),
                  const SizedBox(height: TSizes.spaceBtwSections,),

                  ///Heading
                  TSectionHeading(title: 'Popular Products', onPressed: (){
                    debugPrint('AllProductsScreen');
                    Get.to(() => AllProductsScreen(
                        title: 'Popular Products',
                        //query: FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true).limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                    ));
                  }),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Popular Products
                  ///Static Data
                  //TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVerticalStatic()),
                  ///Dynamic Data
                  Obx((){
                    if(controller.isLoading.value) return const TVerticalProductShimmer();

                    if(controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text('No Data Found!',
                            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black)),
                      );
                    }
                    return TGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]));
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}





















