
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/all_product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.selectSort.value='Name';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.assignProducts(products);
    });
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: controller.selectSort.value,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.sortProducts(value!);
              });

          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale']
              .map((option) => DropdownMenuItem(
              value: option, child: Text(option)))
              .toList(),
        ),

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

