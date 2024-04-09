import 'package:flutter/material.dart';
import 'package:i_store/utils/constants/sizes.dart';

class TGridLayout extends StatelessWidget {
  const TGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 310,
    //this.mainAxisExtent = 288,
    required this.itemBuilder
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent
        ),
        itemBuilder: itemBuilder
    );
  }
}
