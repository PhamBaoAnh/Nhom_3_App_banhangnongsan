import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    controller.selectSort.value = 'Name';

    // Cập nhật sản phẩm khi widget được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.assignProducts(products);
    });

    // Thêm độ trễ 1 giây trước khi trả về widget Column
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)), // Độ trễ 1 giây
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Trong khi chờ đợi, có thể hiển thị một widget loading (spinner)
          return const Center(child: CircularProgressIndicator());
        } else {
          // Khi độ trễ xong, trả về Column
          return Column(
            children: [
              // DropdownButtonFormField cho phép người dùng chọn phương thức sắp xếp
              DropdownButtonFormField<String>(
                value: controller.selectSort.value,
                decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                onChanged: (value) {
                      controller.sortProducts(value!);
                },
                items: ['Name', 'Higher Price', 'Lower Price', 'Sale']
                    .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
                    .toList(),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              // Hiển thị danh sách sản phẩm sau khi sắp xếp
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
      },
    );
  }
}
