import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/features/authentication/controllers/login_controller.dart';
import 'package:i_store/features/authentication/screens/forget_password_screen.dart';
import 'package:i_store/features/authentication/screens/signup_screen.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              ///Email
              TextFormField(
                controller: controller.email,
                validator: (value) => TValidator.validateEmail(value),
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),

              ///Password
              Obx(() => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validateEmptyText(TTexts.password, value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    prefixIcon:const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffix: IconButton(
                        onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye,)
                    )
                ),
              )),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),

              ///Remember me & forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Remember me
                  Row(
                    children: [
                      Obx(() =>
                          Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)
                      ),
                      const Text(TTexts.rememberMe)
                    ],
                  ),

                  ///Forget Password
                  TextButton(onPressed: () => Get.to(() => const ForgetPasswordScreen()), child: const Text(TTexts.forgetPassword))
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                   await controller.emailAndPasswordSignIn();
                    //Get.to(() => const NavigationMenuWidget());
                  }, child: const Text(TTexts.signIn))
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Sign Up Button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: (){
                        Get.to(const SignUpScreen());
                      },
                      child: const Text(TTexts.createAccount))
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        )
    );
  }
}