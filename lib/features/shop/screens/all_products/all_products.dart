import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/appbar/appbar_widget.dart';
import 'package:i_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:i_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:i_store/features/shop/controllers/product/all_products_controller.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing product fetching
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              //Check the state of FutureBuilder snapshot
              const loader = TVerticalProductShimmer();
              ///First method using helper class
              final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

              //Return appropriate widget based on snapshot state
              if(widget != null) return widget;

              ///Second method
            /*  if(snapshot.connectionState == ConnectionState.waiting){
                return loader;
              }
              if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
                return const Center(child: Text('Data Not Found!'));
              }
              if(snapshot.hasError){
                return const Center(child: Text('Something went wrong.'));
              }
            */
              final products = snapshot.data!;
              return TSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}


