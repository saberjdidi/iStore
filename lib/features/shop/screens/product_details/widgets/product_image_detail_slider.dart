import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:i_store/common/widgets/icons/t_circular_icon.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:i_store/features/shop/controllers/product/images_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    //Using for Dynamic Data
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    ///Dynamic data
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child:  Stack(
          children: [
            ///Main large image
             SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImages.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary,)
                      ),
                    );
                  }),
                ),
              ),
            ),

            ///Image Slide
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems,),
                  itemBuilder: (_, index) => Obx((){
                    final imageSelected = controller.selectedProductImages.value == images[index];
                    return TRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      imageUrl: images[index],
                      padding: const EdgeInsets.all(TSizes.sm),
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      onPressed: () => controller.selectedProductImages.value = images[index],
                      border: Border.all(color: imageSelected ? TColors.primary : Colors.transparent),
                      //imageUrl: TImages.productImage3,
                    );
                  })
                ),
              ),
            ),

            ///Appbar Icon
             TAppBar(
              showBackArrow: true,
              actions: [
                TFavoriteIcon(productId: product.id)
                //TCircularIcon(icon: Iconsax.heart5, color: Colors.red,)
              ],
            )
          ],
        ),
      ),
    );

    ///Static data
    /*
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child:  Stack(
          children: [
            ///Main large image
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Image(
                    image: AssetImage(
                        TImages.productImage1
                    ),
                  ),
                ),
              ),
            ),

            ///Image Slide
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems,),
                  itemBuilder: (_, index) => TRoundedImage(
                    width: 80,
                    backgroundColor: dark ? TColors.dark : TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: const EdgeInsets.all(TSizes.sm),
                    imageUrl: TImages.productImage3,
                  ),
                ),
              ),
            ),

            ///Appbar Icon
            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(icon: Iconsax.heart5, color: Colors.red,)
              ],
            )
          ],
        ),
      ),
    );
    */
  }
}
