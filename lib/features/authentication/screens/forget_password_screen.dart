import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/features/authentication/controllers/forget_password_controller.dart';
import 'package:i_store/features/authentication/screens/reset_password_screen.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Headings
            Text(TTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            ///Text Field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),

            ///Submit Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(TTexts.submit))
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
