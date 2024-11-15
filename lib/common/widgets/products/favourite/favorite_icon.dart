import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/favourites_controller.dart';
import '../../icons/t_circular_icon.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});

   final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx (
        () => TCircularIcon(
            icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
            color: controller.isFavorite(productId) ? Colors.red : null,
            onPressed: () => controller.toggleFavoriteProduct(productId),
        )
    );
  }
}
