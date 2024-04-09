import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/features/personalization/controllers/address_controller.dart';
import 'package:i_store/features/personalization/screens/address/add_new_address.dart';
import 'package:i_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(AddressController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const NewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white,),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() => FutureBuilder(
            //use Key to trigger refresh
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot){
                final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);

                //Return appropriate widget based on snapshot state
                if(response != null) return response;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => SingleAddress(
                      address: addresses[index],
                      onTap: (){
                        controller.selectAddress(addresses[index]);
                      }
                  ),

                );
              }
          ))
        ),
      ),
    );
  }
}
