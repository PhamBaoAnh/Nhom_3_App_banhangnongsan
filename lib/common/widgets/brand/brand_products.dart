import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../features/shop/controllers/all_product_controller.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/sizes.dart';
import '../appbar/appbar.dart';
import '../products/sortable/sortbale_products.dart';
import 'brandcard.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brandName, required this.title, this.query, this.futureMethod});
  final String brandName;
  final String title;
  final firestore.Query? query;  // Use firestore.Query to refer to Cloud Firestore Query
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return  Scaffold(
      appBar: TAppBar( title: Text(brandName),showBackArrow: true,),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               TBrandCard(showBorder: true,nameBrand: brandName,),
               const SizedBox(height: TSizes.spaceBtwSections,),
                FutureBuilder(future: controller.fetchProductsByBrand(query,brandName) , builder: (context,snapshot){
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
                })


            ],
          ),


        ),

      ),

    );
  }
}

