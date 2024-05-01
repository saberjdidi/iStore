
import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/features/personalization/controllers/address_controller.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

///Dynamic data
class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () {
          addressController.selectNewAddressPopup(context);
        }),
        addressController.selectedAddress.value.id.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(addressController.selectedAddress.value.name ?? 'Saber Jd', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Text(addressController.selectedAddress.value.phoneNumber ?? '(+216) 71 90 42 11', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: Text(addressController.selectedAddress.value.toString() ?? '45 Av. Kheireddine Pacha, Tunis 1002', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
              ],
            ),
          ],
        )
        /*
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saber Jd', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Text('(+216) 71 90 42 11', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size: 16,),
                const SizedBox(width: TSizes.spaceBtwItems,),
                Expanded(child: Text('45 Av. Kheireddine Pacha, Tunis 1002', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),
              ],
            ),
          ],
        )
         */
        : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

///Static data
/*
class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: (){},),
        Text('Saber Jd', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
         Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text('(+216) 71 90 42 11', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text('45 Av. Kheireddine Pacha, Tunis 1002', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,),
          ],
        ),
      ],
    );
  }
} */
