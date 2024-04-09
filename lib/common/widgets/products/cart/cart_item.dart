
import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/texts/product_title_text.dart';
import 'package:i_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:i_store/features/shop/models/cart_item_model.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItem});
  ///Dynamic Data
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        ///Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          width: 60,
          height: 60,
          backgroundColor: dark ? TColors.darkGrey : TColors.light,
          //border: Border.all(color: TColors.primary),
          padding: const EdgeInsets.all(TSizes.sm),
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),

        ///Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TBrandTitleWIthVerifiedIcon(title: cartItem.brandName ?? ''),
               Flexible(child: TProductTitleText(title: cartItem.title, maxLines: 1,)),

              ///Attributes
              Text.rich(
                  TextSpan(
                      children: (cartItem.selectedVariation ?? {})
                          .entries
                          .map((e) => TextSpan(
                              children: [
                                TextSpan(text: ' ${e.key} ', style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(text: ' ${e.value} ', style: Theme.of(context).textTheme.bodyLarge),
                              ]
                            ))
                          .toList()
                  )
              )
            ],
          ),
        )
      ],
    );
  }


  ///Static Data
  /*
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      children: [
        ///Image
        TRoundedImage(
          width: 60,
          height: 60,
          backgroundColor: dark ? TColors.darkGrey : TColors.light,
          //border: Border.all(color: TColors.primary),
          padding: const EdgeInsets.all(TSizes.sm),
          imageUrl: TImages.productImage1,
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),

        ///Title, Price & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWIthVerifiedIcon(title: 'Nike'),
              const Flexible(child: TProductTitleText(title: 'Black Sports Shoes', maxLines: 1,)),

              ///Attributes
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: 'UK 08', style: Theme.of(context).textTheme.bodyLarge),
                      ]
                  )
              )
            ],
          ),
        )
      ],
    );
  }
   */
}
