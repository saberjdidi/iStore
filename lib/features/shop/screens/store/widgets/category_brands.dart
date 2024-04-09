import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/brands/brand_show_case.dart';
import 'package:i_store/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:i_store/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:i_store/features/shop/controllers/brand_controller.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        //Check the state of FutureBuilder snapshot
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );
        final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

        //Return appropriate widget based on snapshot state
        if(widget != null) return widget;

        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];

            return FutureBuilder(
                future: controller.getBrandProducts(brandId : brand.id, limit : 3),
                builder: (context, snapshot2){
                  final widget2 = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot2, loader: loader);

                  //Return appropriate widget based on snapshot state
                  if(widget2 != null) return widget2;

                  final products = snapshot2.data!;
                  return TBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
                  //return TBrandShowcase(brand: brand, images: const [TImages.productImage3, TImages.productImage2, TImages.productImage1],);
                }
            );

          },
        );

      },
    );

  }
}
