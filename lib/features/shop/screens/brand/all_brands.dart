import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/brands/brand_card.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/shimmer/brands_shimmer.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/controllers/brand_controller.dart';
import 'package:i_store/features/shop/models/brand_model.dart';
import 'package:i_store/features/shop/screens/brand/brand_products.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Heading
              const TSectionHeading(title: 'Brands', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Brands
              Obx((){
                if(controller.isLoading.value) return const TBrandsShimmer();

                if(controller.allBrands.isEmpty){
                  return Center(
                    child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
                  );
                }

                return TGridLayout(
                    itemCount: controller.allBrands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (_, index){
                      final brand = controller.allBrands[index];
                      return TBrandCard(
                          showBorder: false,
                          brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand)),
                      );
                    });
              })
              /*  TGridLayout(itemCount: 10, mainAxisExtent: 80, itemBuilder: (context, index) => TBrandCard(
                  showBorder: true,
                  onTap:() => Get.to(() => const BrandProducts()),
                  brand: BrandModel.empty(),
              )), */
            ],
          ),
        ),
      ),
    );
  }
}
