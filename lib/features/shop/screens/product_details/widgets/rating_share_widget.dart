
import 'package:flutter/material.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ///Rating
        Row(
          children: [
            const Icon(Iconsax.star4, color: Colors.amber, size: 24,),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
                      const TextSpan(text: '(199)',)
                    ]
                )
            )
          ],
        ),

        ///Share button
        IconButton(onPressed: (){}, icon: const Icon(Iconsax.share, size: TSizes.iconMd,))
      ],
    );
  }
}
