import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/form_divider_widget.dart';
import 'package:i_store/common/widgets/social_button_widget.dart';
import 'package:i_store/features/authentication/controllers/signup_controller.dart';
import 'package:i_store/features/authentication/screens/verify_email_screen.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:i_store/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Formulaire
              const TSignupForm(),

              ///Divider
              FormDividerWidget(dividerText: TTexts.orSignUpWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwItems),

              ///Footer
              const SocialButtonsWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              ///Firstanme & Lastname
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyText(TTexts.firstName, value),
                      expands: false,
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: TTexts.firstName),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields,),
                  Expanded(
                    child: TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyText(TTexts.lastName, value),
                      expands: false,
                      decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: TTexts.lastName),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),

              ///Username
              TextFormField(
                controller: controller.username,
                validator: (value) => TValidator.validateEmptyText(TTexts.username, value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user_edit), labelText: TTexts.username),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),

              ///Email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct), labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),

              ///Phone Number
              TextFormField(
                controller: controller.phoneNumber,
                validator: (value) => TValidator.validatePhoneNumber(value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),

              ///Password
              Obx(() => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
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
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),

              ///Terms & Conditions
              Row(
                children: [
                  SizedBox(
                      width: 24, 
                      height: 24,
                      child: Obx(() => Checkbox(
                          value: controller.privacyPolicy.value,
                          onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value
                      ))
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Flexible(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${TTexts.privacyPolicy} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark ? TColors.white : TColors.primary,
                        )),
                        TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: TTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark ? TColors.white : TColors.primary,
                        )),
                      ])
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.signup(),
                      child: const Text(TTexts.createAccount))
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        )
    );
  }
}
