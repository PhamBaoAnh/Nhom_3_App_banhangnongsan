
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/cart_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/productc_detail/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key, required this.product,
  });

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return InkWell(
      onTap: (){
        if(product.productType == ProductType.single.toString()){
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        }else{
          Get.to(() => ProductDetail(product: product,));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(product.id);
          return Container(
          decoration:  BoxDecoration(
              color: productQuantityInCart > 0 ? TColors.primary : TColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(TSizes.cardRadiusMd),
                bottomRight: Radius.circular(TSizes.productImageRadius),
              )
          ),
          child:  SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(productQuantityInCart.toString(),style: TextStyle(color: productQuantityInCart > 0 ? TColors.white : TColors.white), )
                  :  const Icon(Iconsax.add, color: TColors.white,),
            ),
          ),
          );
        }),
    );
  }
}