import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:i_store/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/controllers/category_controller.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/features/shop/screens/all_products/all_products.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';

///Dynamic SubCategory
class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(category.name, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              const TRoundedImage(imageUrl: TImages.promoBanner1, width: double.infinity, applyImageRadius: true,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///Sub-Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot){
                    //Check the state of FutureBuilder snapshot
                    const loader = THorizontalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                    //Return appropriate widget based on snapshot state
                    if(widget != null) return widget;

                    final subCategories = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];

                        return FutureBuilder(
                            future: controller.getCategoryProducts(categoryId: subCategory.id),
                          builder: (context, snapshot2) {
                            //Check the state of FutureBuilder snapshot
                            final widget2 = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot2, loader: loader);
                            //Return appropriate widget based on snapshot state
                            if(widget2 != null) return widget2;

                            final products = snapshot2.data!;

                            return Column(
                              children: [
                                ///Heading
                                TSectionHeading(
                                    title: subCategory.name,
                                    onPressed: () => Get.to(
                                        () => AllProductsScreen(
                                            title: subCategory.name,
                                          futureMethod: controller.getCategoryProducts(categoryId: subCategory.id, limit: -1),
                                        )
                                    )
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems / 2),

                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: products.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, __) => const SizedBox(height: TSizes.spaceBtwSections),
                                    itemBuilder: (context, index) {
                                      return TProductCardHorizontal(product : products[index]);
                                    },
                                  ),
                                ),
                                const SizedBox(height: TSizes.spaceBtwSections),
                              ],
                            );
                          }
                        );

                      },
                    );

                  }
              )
              
            ],
          ),
        ),
      ),
    );
  }
}

///Static SubCategory
/*
class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Sports', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              const TRoundedImage(imageUrl: TImages.promoBanner1, width: double.infinity, applyImageRadius: true,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///Sub-Categories
              Column(
                children: [
                  ///Heading
                  TSectionHeading(title: 'Sports shirts', onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, __) => const SizedBox(height: TSizes.spaceBtwSections),
                      itemBuilder: (context, index) {
                        return  const TProductCardHorizontal();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */
