import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/image_strings.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar( showBackArrow: true, title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall,),),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections,),
              itemCount: 6,
            itemBuilder: (_, index) => const Column(
              children: [
                TCartItem(),
                SizedBox(height: TSizes.spaceBtwItems ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [

                    Row(
                      children: [
                          SizedBox(width: 70 ),
                          TProductQuantityRemoveButton(),

                      ],
                    ),
                    TProductPriceText(price: '125.000',)
                  ],
                ),

              ],

            ),

          ),

      ),
     bottomNavigationBar: Padding(
       padding: const EdgeInsets.all(TSizes.defaultSpace),
       child: ElevatedButton(
           onPressed: (){},
           child: const Text('Check out \500.000 VND' ),
           style: ElevatedButton.styleFrom(
             backgroundColor: TColors.primary,
             side: const BorderSide(color: TColors.primary)
           ),
       ),
     ),
    );
  }
}




