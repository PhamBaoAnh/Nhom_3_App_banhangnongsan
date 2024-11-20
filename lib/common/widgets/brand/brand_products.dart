import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/features/shop/models/brand_model.dart';

import '../../../features/shop/controllers/all_product_controller.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/sizes.dart';
import '../appbar/appbar.dart';
import '../products/sortable/sortbale_products.dart';
import 'brandcard.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key,required this.title, this.query, this.futureMethod, required this.brand});
  final BrandModel brand;
  final String title;
  final firestore.Query? query;  // Use firestore.Query to refer to Cloud Firestore Query
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return  Scaffold(
      appBar: TAppBar( title: Text(brand.name),showBackArrow: true,),
      body:  SingleChildScrollView(


        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:    FutureBuilder(future: controller.fetchProductsByBrand(query,brand.name) , builder: (context,snapshot){
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
            return Column(
            children: [
               TBrandCard(showBorder: true,brand: brand,),
               const SizedBox(height: TSizes.spaceBtwSections,),
               TSortableProducts(products: products)]
                );
    }
          ),


        ),

      ),

    );
  }
}

