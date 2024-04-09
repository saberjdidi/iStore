import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:i_store/common/widgets/images/t_rounded_images.dart';
import 'package:i_store/common/widgets/shimmer.dart';
import 'package:i_store/features/shop/controllers/banner_controller.dart';
import 'package:i_store/features/shop/controllers/home_controller.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  ///Dynamic Data
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx((){
      if(controller.isLoading.value) return const TShimmerEffect(width: double.infinity, height: 190);

      if(controller.bannersList.isEmpty) {
        return Center(
          child: Text('No Data Found!',
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.black)),
        );
      }
      else {
        return Column(
          children: [
            CarouselSlider(
                options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, _) => controller.updatePageIndicator(index)
                ),
                items: controller.bannersList.map(
                        (banner) => TRoundedImage(
                      imageUrl:banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    )
                ).toList()
            ),
            const SizedBox(height: TSizes.spaceBtwItems,),
            Center(
              child: Obx(() =>
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.bannersList.length; i++) TCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor: controller.carousalCurrentIndex.value == i ? TColors.primary : TColors.grey,
                      )
                    ],
                  )),
            )
          ],
        );
      }
    });
  }

  ///Static Data
 /*
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
             onPageChanged: (index, _) => controller.updatePageIndicator(index)
          ),
          items: banners.map((url) => TRoundedImage(imageUrl:url)).toList()
        /*  const [
            TRoundedImage(imageUrl:TImages.promoBanner1),
            TRoundedImage(imageUrl:TImages.promoBanner2),
            TRoundedImage(imageUrl:TImages.promoBanner3),
          ], */
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Center(
          child: Obx(() =>
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < banners.length; i++) TCircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carousalCurrentIndex.value == i ? TColors.primary : TColors.grey,
                  )
                ],
              )),
        )
      ],
    );
  }
  */
}