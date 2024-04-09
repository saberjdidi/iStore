
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/personalization/controllers/settings_controller.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SettingsController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Upload Data', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            ///Account Settings
            const TSectionHeading(title: 'Main Record', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            TSettingsMenuTile(
                icon: Iconsax.category,
                title: 'Upload Categories',
                subTitle: '',
                trailing: const Icon(Icons.upload, color: TColors.primary, size: 28),
              onTap: () {
                controller.uploadDataOfCategories();
              },
            ),
            TSettingsMenuTile(
                icon: Iconsax.image,
                title: 'Upload Banners',
                subTitle: '',
                trailing: const Icon(Icons.upload, color: TColors.primary, size: 28),
              onTap: () {
                controller.uploadDataOfBanners();
              },
            ),
            TSettingsMenuTile(
                icon: Iconsax.story,
                title: 'Upload Brands',
                subTitle: '',
                trailing: const Icon(Iconsax.import_1, color: TColors.primary, size: 28),
              onTap: () {
                controller.uploadDataOfBrands();
              },
            ),
            TSettingsMenuTile(
                icon: Iconsax.image5,
                title: 'Upload Products',
                subTitle: '',
                trailing: const Icon(Iconsax.import_1, color: TColors.primary, size: 28),
              onTap: () {
                controller.uploadDataOfProducts();
              },
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            ///RelationShip Settings
            const TSectionHeading(title: 'RelationShip Record', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems,),

            TSettingsMenuTile(
              icon: Iconsax.gallery_import,
              title: 'Upload Brands Categories',
              subTitle: '',
              trailing: const Icon(Iconsax.import_1, color: TColors.primary, size: 28),
              onTap: () {
                controller.uploadDataOfBrandsCategories();
              },
            ),
          ],
        ),
      ),
    );
  }
}
