import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants/sizes.dart';
import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/banner_model.dart';
import '../../models/product_model.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    // Khởi tạo ảnh thumbnail làm ảnh đầu tiên nếu chưa có ảnh được chọn
    if (selectedProductImage.value.isEmpty) {
      selectedProductImage.value = product.thumbnail;
    }
    images.add(product.thumbnail);

    // Thêm các ảnh từ product.images nếu có
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Thêm ảnh từ productVariations nếu có
    if (product.productVariations != null && product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }


  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Container(
          color: TColors.white, // Thêm màu nền đen mờ
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
