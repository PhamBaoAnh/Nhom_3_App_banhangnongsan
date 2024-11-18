import 'package:flutter/material.dart';

import '../../../../features/shop/models/cart_item_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key, required this.cartItem,
  });

   final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 70,
          height: 70,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        Expanded(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifidedIcon(title: cartItem.brandName ?? ''),
               Flexible(child: TProductTitleText(title: cartItem.title, maxLines: 1,)),
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries.map((e) {
                    return TextSpan(
                      children: [
                        TextSpan(
                          text: ' ${e.key}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: ' ${e.value}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  }).toList(), // Convert Iterable<TextSpan> to List<TextSpan>
                ),
              )

            ],
          ),
        )



      ],
    );
  }
}

