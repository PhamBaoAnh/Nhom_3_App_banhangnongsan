
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return  Column(
        children: [
          DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            onChanged: (value){},
            items: ['name', 'Higher Price', 'Sale']
                .map((option) =>   DropdownMenuItem(
                value: option, child: Text(option)))
                .toList(),

          ),

          const SizedBox(height: TSizes.spaceBtwItems,),

          TGridLayout(itemCount: 10,
              itemBuilder: (_, index) => TProductCardVertical(product: controller.featuredProducts[index]) ),


        ],


    );
  }
}

