import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  ///Variables
  RxString selectedProductImages = ''.obs;

  ///Get all images from Product and Variations
  List<String> getAllProductImages(ProductModel product){
  //Use Set to add unique images only
    Set<String> images = {};

    //Load thumbnail image
    images.add(product.thumbnail);

    //Assign thumbnail as selected image
    selectedProductImages.value = product.thumbnail;

    //Get all images from the Product Model if not null
    if(product.images != null){
      images.addAll(product.images!);
    }

    //Get all images from the Product Variations if not null
    if(product.productVariations != null || product.productVariations!.isNotEmpty){
      images.addAll(product.productVariations!.map((e) => e.image));
    }

    return images.toList();
  }

  ///Show Image Popup
  void showEnlargedImage(String image){
   Get.to(
     fullscreenDialog: true,
       () => Dialog.fullscreen(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
               child: CachedNetworkImage(imageUrl: image),
             ),

             const SizedBox(height: TSizes.spaceBtwSections,),

             Align(
               alignment: Alignment.bottomCenter,
               child: SizedBox(
                 width: 150,
                 child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
               ),
             )
           ],
         ),
       )
   );
  }
}