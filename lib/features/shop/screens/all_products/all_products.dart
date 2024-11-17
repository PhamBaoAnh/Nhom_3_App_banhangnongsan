import 'package:cloud_firestore/cloud_firestore.dart' as firestore;  // Alias for Cloud Firestore
// Alias for Firebase Realtime Database
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortbale_products.dart';
import '../../../../utils/constants/sizes.dart';

class AllProduct extends StatelessWidget {
  final String title;
  final firestore.Query? query;  // Use firestore.Query to refer to Cloud Firestore Query
  final Future<List<ProductModel>>? futureMethod;

  const AllProduct({super.key, required this.title, this.query, this.futureMethod});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Tất cả các sản phẩm',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsQuery(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {

                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No featured products available.'));
                }
                final products =snapshot.data!;
                return  TSortableProducts(products: products);
              }
          ),
        ),
      ),
    );
  }
}
