
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/category_model.dart';

import '../../../../common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/products/sortable/sortbale_brand.dart';
import '../../../../common/widgets/products/sortable/sortbale_products.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/product_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String title;
  final firestore.Query? query;  // Use firestore.Query to refer to Cloud Firestore Query
  final Future<List<ProductModel>>? futureMethod;
  final String  categoryId ;
  final String categoryName;
  const SubCategoriesScreen({super.key, required this.title, this.query, this.futureMethod, required this.categoryId, required this.categoryName});
  @override
  Widget build(BuildContext context) {

    final controllerProduct =Get.put(ProductController());
    return Scaffold(
      appBar: TAppBarBack(
        showBackArrow: true,
        title: Text(
          categoryName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: controllerProduct.getProductsByCategory(categoryId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData && snapshot.data != null) {
                  final products = snapshot.data!;
                  return TSortableProducts(products: products);
                } else {
                  return const Center(child: Text('No featured products available.'));
                }

              }
          ),
        ),
      ),
    );
  }
}
