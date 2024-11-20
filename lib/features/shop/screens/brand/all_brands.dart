import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brand/brand_products.dart';
import '../../../../common/widgets/brand/brandcard.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final controllerBrand = Get.put(BrandController());
    return Scaffold(
        appBar: const TAppBar(
          showBackArrow: true,
          title: Text('Brand'),
        ),
        body: FutureBuilder(
            future: controllerBrand.getAllBrands(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final brands = snapshot.data ?? [];
              print(brands.length);
              if (brands.isEmpty) {
                return const Center(child: Text('No brands available.'));

              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(children: [
                    const TSectionHeading(
                      title: 'Brand',
                      textColor: TColors.black,
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    TGridLayout(
                        itemCount: brands.length,
                        mainAxisExtent: 80,
                        itemBuilder: (context, index) => TBrandCard(
                            brand:brands[index],
                            showBorder: true,
                            onTap: () => Get.to(() => BrandProducts(
                                brand: brands[index],
                                title: 'Popular Products',
                                query: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('IsFeatured', isEqualTo: true)
                                    .limit(6),
                                futureMethod:
                                    controller.fetchAllFeaturedProducts()))))
                  ]),
                ),
              );
            }));
  }
}
