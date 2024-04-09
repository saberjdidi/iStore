import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/features/personalization/controllers/user_controller.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: Text('Re-Authenticate User', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields,),
                Obx(() => TextFormField(
                  controller: controller.verifyPassword,
                  validator: (value) => TValidator.validateEmptyText(TTexts.password, value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon:const Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffix: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)
                      )
                  ),
                )),
                const SizedBox(height: TSizes.spaceBtwSections,),

                ///Login Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                         await controller.reAuthenticateEmailAndPasswordUser();
                        },
                        child: const Text('Verify')
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
