import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/features/shop/models/category_model.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../../../common/widgets/brand/brand_show_case.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/product_controller.dart';
import '../../all_products/all_products.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category, required this.brand});

  final CategoryModel category;
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProductController());
    return FutureBuilder<List<ProductModel>>(
        future: controller.getProductsByCategory(category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Waiting');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('0 product');
          }
            List<ProductModel> list = snapshot.data!;
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(children: [
                    TBrandShowcase(
                      images: const[

                        TImages.productImage2,
                        TImages.productImage1,
                        TImages.productImage1,
                      ],
                      category: category, brand: brand,
                    ),
                    TSectionHeading(
                      title: 'Quốc Gia',
                      showActionButton: true,
                      onPressed: () => Get.to(() =>  AllProduct(title: 'Popular Products',query: FirebaseFirestore.instance
                          .collection('Products')
                          .where('IsFeatured', isEqualTo: true)
                          .limit(6),futureMethod:controller.fetchAllFeaturedProducts())),
                      textColor: TColors.black,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TGridLayout(
                      itemCount: list.length,
                      itemBuilder: (_, index) {
                        return TProductCardVertical(product: list[index]);
                      },
                    )
                  ]),
                )
              ],
            );

        });
  }
}
