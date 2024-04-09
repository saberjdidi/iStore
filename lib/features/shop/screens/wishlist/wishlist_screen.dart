import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/icons/t_circular_icon.dart';
import 'package:i_store/common/widgets/layouts/grid_layout.dart';
import 'package:i_store/common/widgets/loaders/animation_loader.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:i_store/common/widgets/products/product_cards/product_card_vertical_static.dart';
import 'package:i_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:i_store/features/shop/controllers/product/favorites_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/screens/home/home_screen.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = FavoritesController.instance;

    return Scaffold(
        appBar: TAppBar(
          title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen()))
          ],
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          ///Products Grid
          ///Dynamic Data
          child: Obx(() => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot){
                ///Nothing Found Widget
                final emptyWidget = TAnimationLoaderWidget(
                  text: 'Whoops! Wishlist is empty...',
                  animation: TImages.pencilAnimation,
                  showAction: true,
                  actionText: 'Let\'s add some',
                  onActionPressed: () => Get.off(() => const NavigationMenuWidget()),
                );
                //Check the state of FutureBuilder snapshot
                const loader = TVerticalProductShimmer(itemCount: 6,);
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                //Return appropriate widget based on snapshot state
                if(widget != null) return widget;

                final products = snapshot.data!;
                return TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => TProductCardVertical(product: products[index])
                );
              }
          )),
          ///Static Data
         /* child: Column(
            children: [
              TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVerticalStatic),
            ],
          ), */
        ),
      ),
    );
  }
}
