import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';

import '../../../../../common/widgets/animation/animation_page_route_transition.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/category_controller.dart';
import '../../sub_category/sub_categories.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.put(ProductController());
    return Obx(() {
      // Kiểm tra xem danh sách danh mục có trống hay không
      if (categoryController.allCategories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
      }
      // Nếu có danh mục, xây dựng giao diện
      return SizedBox(
        height: 85,
        child: ListView.builder(
          itemCount: categoryController.allCategories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: TVerticalImageText(
                image: category.image, // Passing the image URL (String)
                title: category.name,
                  onTap: () => Navigator.of(context).push(
                    customPageRoute(
                        SubCategoriesScreen(
                            categoryName: category.name,
                            categoryId : category.id,
                            title: 'Product in Category',
                            query: FirebaseFirestore.instance
                                .collection('Products')
                                .where('IsFeatured', isEqualTo: true)
                                .where('CategoryId', isEqualTo: category.parentId)
                            ,
                            futureMethod: productController.fetchAllFeaturedProducts())
                    ),
                  ),
              )
              );

          },
        ),
      );
    });
  }
}
