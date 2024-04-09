import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/features/personalization/controllers/update_name_controller.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Headings
            Text('Use real name for easy verification. This name will appear on several pages.',
             style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections,),

            ///Text field and button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => TValidator.validateEmptyText(TTexts.firstName, value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: TTexts.firstName),
                    expands: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields,),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => TValidator.validateEmptyText(TTexts.lastName, value),
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: TTexts.lastName),
                    expands: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),

            ///Save Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save'))
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
