
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';

import 'package:project/features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableBrands extends StatelessWidget {
  final List<ProductModel> products;
  const TSortableBrands({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    final controllerBrand =Get.put(BrandController());
    controllerBrand.getNameAllBrands();
   controller.selectBrand.value='Việt Nam';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.assignProductBrands(products);
      controller.filterBrand('Việt Nam');

    });
    return Column(
      children: [
        DropdownButtonFormField<String>(
            value: controller.selectBrand.value.isNotEmpty
                ? controller.selectBrand.value
                : null,
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            onChanged: (value) {
              if (value != null) {
                controller.assignProducts(products);
                controller.filterBrand(value);
              }
            },
            items: controllerBrand.nameBrands
                .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
          )

        ,
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(
              () => TGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                TProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}

