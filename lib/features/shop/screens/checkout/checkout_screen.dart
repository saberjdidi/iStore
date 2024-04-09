
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/common/widgets/products/cart/coupon_widget.dart';
import 'package:i_store/common/widgets/success_screen.dart';
import 'package:i_store/features/shop/controllers/product/cart_controller.dart';
import 'package:i_store/features/shop/controllers/product/order_controller.dart';
import 'package:i_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:i_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:i_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:i_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';
import 'package:i_store/utils/helpers/pricing_calculator.dart';
import 'package:i_store/utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subTotal, 'US');

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
                ///Items in cart
              const TCartItems(showAndRemoveButtons: false,),
              const SizedBox(height: TSizes.spaceBtwSections,),
              ///Coupon TextField
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections,),

              ///Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    ///Pricing
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    ///Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    ///Payment Method
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems,),

                    ///Address
                    TBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => TLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
          child: Text('Checkout \$$totalAmount'),
          //child: Text('Checkout \$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}'),
        ),
      ),
     /* bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() =>  SuccessScreen(
            image: TImages.successfulPaymentIcon,
            title: 'Payment Success!',
            subTitle: 'Your item will be shipped soon!',
            onPressed: () => Get.offAll(() => const NavigationMenuWidget()),
          )),
          child: Text('Checkout \$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}'),
        ),
      ), */
    );
  }
}