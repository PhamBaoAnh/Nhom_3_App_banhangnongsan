import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/cart_controller.dart';
import '../../../models/product_model.dart';

class TButtonAddToCart extends StatelessWidget {
  const TButtonAddToCart({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {

    final controller = CartController.instance;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateAlreadyAddedProductCount(product);
    });

    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight:  Radius.circular(TSizes.cardRadiusLg),
        )
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Obx(
           () => Row(
             children: [
                TCircularIcon(
                 icon: Iconsax.minus,
                 backgroundColor: TColors.primary,
                 width: 40,
                 height: 40,
                 color: TColors.white,
                  onPressed: () => controller.productQuantityCart.value < 1 ? null : controller.productQuantityCart.value -=1,
               ),
               const SizedBox(width: TSizes.spaceBtwItems ,),
               Text(controller.productQuantityCart.value.toString(), style: Theme.of(context).textTheme.titleSmall,),
               const SizedBox(width: TSizes.spaceBtwItems ,),
                TCircularIcon(
                 icon: Iconsax.add,
                 backgroundColor: TColors.primary,
                 width: 40,
                 height: 40,
                 color: TColors.white,
                    onPressed: () => controller.productQuantityCart.value +=1,
               ),
             ],
           ),
         ),
          ElevatedButton(
            onPressed: () => controller.addToCart(product),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary),
            ),
            child: const Text('Thêm vào giỏ hàng'),
          ),
        ],
      ),

    );
  }
}
