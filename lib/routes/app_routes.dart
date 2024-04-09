import 'package:get/get.dart';
import 'package:i_store/features/authentication/screens/forget_password_screen.dart';
import 'package:i_store/features/authentication/screens/login_screen.dart';
import 'package:i_store/features/authentication/screens/onboarding_screen.dart';
import 'package:i_store/features/authentication/screens/signup_screen.dart';
import 'package:i_store/features/authentication/screens/verify_email_screen.dart';
import 'package:i_store/features/personalization/screens/address/address_screen.dart';
import 'package:i_store/features/personalization/screens/profile/profile_screen.dart';
import 'package:i_store/features/personalization/screens/settings/settings_screen.dart';
import 'package:i_store/features/shop/screens/cart/cart_screen.dart';
import 'package:i_store/features/shop/screens/checkout/checkout_screen.dart';
import 'package:i_store/features/shop/screens/favorite/favourite_screen.dart';
import 'package:i_store/features/shop/screens/home/home_screen.dart';
import 'package:i_store/features/shop/screens/order/order_screen.dart';
import 'package:i_store/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:i_store/features/shop/screens/store/store_screen.dart';
import 'package:i_store/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:i_store/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const WishlistScreen()),
    //GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}