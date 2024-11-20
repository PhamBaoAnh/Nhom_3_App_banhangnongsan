import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return FutureBuilder(
        future: controller.getProductsByCategory(category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('0 product');
          } else {
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
                      categoryId: category.id,
                    ),
                    TSectionHeading(
                      title: 'Quốc Gia',
                      showActionButton: true,
                      onPressed: () {},
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
          }
        });
  }
}
