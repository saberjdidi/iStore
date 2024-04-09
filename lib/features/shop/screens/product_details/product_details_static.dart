import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:i_store/common/widgets/icons/t_circular_icon.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:i_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:i_store/features/shop/screens/product_details/widgets/product_image_detail_slider.dart';
import 'package:i_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:i_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:i_store/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsStatic extends StatelessWidget {
  const ProductDetailsStatic({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: ProductModel.empty(),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Product image slider
             TProductImageSlider(product: ProductModel.empty(),),

            ///Product Details
            Padding(
              padding: EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Rating & share button
                  TRatingAndShare(),

                  ///Title, Price & Stock
                  TProductMetaData(product: ProductModel.empty()),

                  ///Attributes
                  TProductAttributes(product: ProductModel.empty()),
                  const SizedBox(height: TSizes.spaceBtwSections,),

                  ///Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: const Text('Checkout')
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,),

                  ///Description
                  const TSectionHeading(title: 'Description', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'This is product description for Blue Nike Sleeve less vest.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  ///Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Reviews (199)', showActionButton: false,),
                      IconButton(icon: const Icon(Iconsax.arrow_right, size: 18), onPressed: ()=> Get.to(()=> const ProductReviewsScreen()))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
