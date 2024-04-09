import 'package:flutter/material.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/features/shop/screens/order/widgets/order_list.dart';
import 'package:i_store/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('My Orders', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TOrderListItems(),
      ),
    );
  }
}
