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
import 'package:i_store/utils/enums.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(product: product,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Product image slider
             TProductImageSlider(product: product),

            ///Product Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Rating & share button
                  const TRatingAndShare(),

                  ///Title, Price & Stock
                  TProductMetaData(product: product),

                  ///Attributes
                  if(product.productType == ProductType.variable.toString()) TProductAttributes(product: product),
                  if(product.productType == ProductType.variable.toString()) const SizedBox(height: TSizes.spaceBtwSections,),

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
                   ReadMoreText(product.description ?? '',
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
