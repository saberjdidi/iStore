import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/styles/spacing_styles.dart';
import 'package:i_store/common/widgets/form_divider_widget.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/common/widgets/social_button_widget.dart';
import 'package:i_store/features/authentication/screens/forget_password_screen.dart';
import 'package:i_store/features/authentication/screens/login_screen.dart';
import 'package:i_store/features/authentication/screens/signup_screen.dart';
import 'package:i_store/features/authentication/widgets/login_form.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo, Title, SubTitle
              TLoginHeader(dark: dark),

              ///Formulaire
              const TLoginForm(),

              ///Divider
              FormDividerWidget(dividerText: TTexts.orSignInWith.capitalize!),

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

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
        Text(TTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: TSizes.sm,),
        Text(TTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center),
      ],
    );
  }
}
