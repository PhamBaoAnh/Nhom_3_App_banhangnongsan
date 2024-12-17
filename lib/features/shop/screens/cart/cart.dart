import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/image_strings.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../common/widgets/animation/animation_loader.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/navigation_menu.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBarBack( showBackArrow: true, title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall,),),
      body: Obx((){

        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! Giỏ hàng của bạn đang trống !!',
          animation: TImages.loaderAnimation ,
          showAction: true,
          actionText: 'Đặt hàng ngay nào !',
          onActionPressed: () => Get.off(()=> const NavigationMenu()),
        );

        if(controller.cartItems.isEmpty){
          return emptyWidget;
        }else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TCartItems(),

            ),
          );
        }


      }),

      bottomNavigationBar: Obx(() {
        return controller.cartItems.isEmpty
            ? const SizedBox.shrink() // Không hiển thị gì nếu giỏ hàng trống
            : Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary),
            ),
            child: Text(
              'Check out ${NumberFormat.decimalPattern('vi').format(controller.totalCartPrice.value)} VND',
            ),
          ),
        );
      }),
    );
  }
}