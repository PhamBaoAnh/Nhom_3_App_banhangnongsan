import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key, required this.iconColor , required this.onPressed, required this.iconColor2,
  });
  final Color iconColor;
  final Color iconColor2;
  final VoidCallback onPressed ;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(CartController());

    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(
                  () => const CartScreen(),
              transition: Transition.downToUp,
              duration: const Duration(milliseconds: 600),
            ),
            icon:  Icon(Iconsax.shopping_bag, color: iconColor,)
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(color: iconColor2,
                      fontSizeFactor: 0.8 ),),
              ),
            ),
          ),

        ),
      ],
    );
  }
}


