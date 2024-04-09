import 'package:flutter/material.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/device/device_utility.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

class TTabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TTabBarWidget({
    super.key,
    required this.tabs,
    this.leadingOnPressed,
  });

  final List<Widget> tabs;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.white,
        unselectedLabelColor: TColors.darkGrey,
        labelColor: dark ? TColors.white : TColors.light,
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
