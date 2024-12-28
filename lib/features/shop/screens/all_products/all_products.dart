import 'package:cloud_firestore/cloud_firestore.dart' as firestore;  // Alias for Cloud Firestore
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/sortable/sortbale_products.dart';
import '../../../../utils/constants/sizes.dart';

class AllProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBarBack(
        showBackArrow: true,
        title: Text(
          'Tất cả các sản phẩm',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder<List<ProductModel>>(
              future: controller.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                // Kiểm tra xem dữ liệu có tồn tại hay không
                if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                final products = snapshot.data!;
                return TSortableProducts(products: products);
              }
          ),
        ),
      ),
    );
  }
}
