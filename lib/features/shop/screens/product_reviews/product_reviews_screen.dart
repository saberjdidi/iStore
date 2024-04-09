
import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/products/ratings/rating_indicator.dart';
import 'package:i_store/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:i_store/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:i_store/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/device/device_utility.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///AppBar
      appBar: const TAppBar(title: Text('Reviews & Ratings'), showBackArrow: true,),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ratings and reviews are verified and are from people who use the same type of device that you use.'),
              const  SizedBox(height: TSizes.spaceBtwItems,),

              ///Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 3.5,),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

