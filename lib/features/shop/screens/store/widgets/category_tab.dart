import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/features/shop/models/category_model.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/features/shop/screens/all_products/all_product_brands.dart';

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
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final List<ProductModel> listAll = snapshot.data ?? [];
          final list = listAll
              .where((product) => product.brand?.name == brand.name)
              .toList();
          // Extract thumbnails safely
          final images = list.length >= 3
              ? [list[0].thumbnail, list[1].thumbnail, list[2].thumbnail]
              : list.map((product) => product.thumbnail).toList();
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TBrandShowcase(
                      images: images,
                      category: category,
                      brand: brand,
                    ),
                    TSectionHeading(
                      title: 'Quốc Gia',
                      showActionButton: true,
                      onPressed: () => Get.to(() => AllProductBrands(
                            title: 'Popular Products',
                            query: FirebaseFirestore.instance
                                .collection('Products')
                                .where('IsFeatured', isEqualTo: true)
                                .where('CategoryId', isEqualTo: category.parentId)
                                .limit(6),
                            futureMethod: controller.fetchAllFeaturedProducts(),
                          )),
                      textColor: TColors.black,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TGridLayout(
                      itemCount: listAll.length,
                      itemBuilder: (_, index) {
                        return TProductCardVertical(product: listAll[index]);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}
