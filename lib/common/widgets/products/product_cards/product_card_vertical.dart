import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/styles/shadows.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:i_store/common/widgets/icons/t_circular_icon.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:i_store/common/widgets/texts/product_price_text.dart';
import 'package:i_store/common/widgets/texts/product_title_text.dart';
import 'package:i_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:i_store/features/shop/controllers/product/product_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/screens/cart/widgets/add_to_cart_button.dart';
import 'package:i_store/features/shop/screens/product_details/product_details.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/enums.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  //Using when is dynamic data
 final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);

    ///Container
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white
        ),
        child: Column(
          children: [
            ///Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              width: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  ///Thumbnail Image
                  Center(child: TRoundedImage(imageUrl: product.thumbnail, applyImageRadius: true, isNetworkImage: true,)),
                  //const TRoundedImage(imageUrl: TImages.productImage1, applyImageRadius: true,),
                  ///Sale Tag
                  if(salePercentage != null)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.black)),
                      ),
                    ),

                  ///Favorite Icon Button
                   Positioned(
                    top: 0,
                    right: 0,
                    child: TFavoriteIcon(productId: product.id),
                  )
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            ///Details
             Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(title: product.title, smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWIthVerifiedIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ///Price
                 Flexible(
                   child: Column(
                     children: [
                       if(product.productType == ProductType.single.toString() && product.salePrice > 0)
                         Padding(
                           padding: const EdgeInsets.only(left: TSizes.sm),
                           child: Text(
                             product.price.toString(),
                             style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                           ),
                         ),

                       Padding(
                        padding: const EdgeInsets.only(left: TSizes.sm),
                        child: TProductPriceText(price: controller.getProductPrice(product)),
                       ),
                     ],
                   ),
                 ),

                ///Add to Cart Button
                ProductCardAddToCartButton(product: product)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
