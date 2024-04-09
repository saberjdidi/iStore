
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/appbar/tabbar_widget.dart';
import 'package:i_store/common/widgets/brands/brand_card.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:i_store/common/widgets/shimmer/brands_shimmer.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/shop/controllers/brand_controller.dart';
import 'package:i_store/features/shop/controllers/category_controller.dart';
import 'package:i_store/features/shop/screens/brand/all_brands.dart';
import 'package:i_store/features/shop/screens/cart/cart_screen.dart';
import 'package:i_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon()
            //TCartCounterIcon(onPressed: () => Get.to(() => const CartScreen()))
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled){
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
                 child: ListView(
                   physics: const NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   children: [
                     ///SearchBar
                     const SizedBox(height: TSizes.spaceBtwItems,),
                     const TSearchContainer(text: 'Search in Store', showBorder: true, showBackground: false, padding: EdgeInsets.zero,),
                     const SizedBox(height: TSizes.spaceBtwSections),

                     ///Featured Brands
                     TSectionHeading(title: 'Featured Brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                     const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                     ///Brand GRID
                     Obx((){
                       if(brandController.isLoading.value) return const TBrandsShimmer();

                       if(brandController.featuredBrands.isEmpty){
                         return Center(
                           child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
                         );
                       }

                       return TGridLayout(
                           itemCount: brandController.featuredBrands.length,
                           mainAxisExtent: 80,
                           itemBuilder: (_, index){
                             final brand = brandController.featuredBrands[index];
                             return TBrandCard(showBorder: false, brand: brand);
                           });
                     }),
                   ],
                 ),),
                ///Tabs
                bottom: TTabBarWidget(
                  tabs: categories.map((category) => Tab(child: Text(category.name))).toList()
                ),
                /*
                bottom: const TTabBarWidget(
                  tabs: [
                    Tab(child: Text('Sports'),),
                    Tab(child: Text('Furniture'),),
                    Tab(child: Text('Electronics'),),
                    Tab(child: Text('Clothes'),),
                    Tab(child: Text('Cosmetics'),),
                  ],
                ),
                 */
              )
            ];
          },
          ///Body
          body: TabBarView(
            children: categories.map((category) => TCategoryTab(category: category)).toList(),
           /* children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],*/
          ),
        ),
      ),
    );
  }
}

