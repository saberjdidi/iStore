
import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/texts/t_brand_title_text.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/enums.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWIthVerifiedIcon extends StatelessWidget {
  const TBrandTitleWIthVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(height: TSizes.xs),
        const Icon(Iconsax.verify5, color: TColors.primary, size: TSizes.iconXs,)
      ],
    );
  }
}
