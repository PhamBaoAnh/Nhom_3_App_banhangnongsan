import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,

  });
  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections,),
      itemCount: 4,
      itemBuilder: (_, index) => Column(
        children: [
          const TCartItem(),
          if(showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems ),

          if(showAddRemoveButton)
            const Row(
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

    );
  }
}
