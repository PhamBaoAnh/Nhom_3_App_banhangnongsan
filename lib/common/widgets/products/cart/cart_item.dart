import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';
import '../../texts/t_brand_title_with_verified_icon.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: TImages.productImage2,
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        Expanded(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifidedIcon(title: 'Hà Nội '),
              const Flexible(child: TProductTitleText(title: 'Cherry', maxLines: 1,)),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: 'Khối lương ',style: Theme.of(context).textTheme.bodySmall ),
                        TextSpan(text: '1Kg',style: Theme.of(context).textTheme.bodyLarge ),

                      ]
                  )
              )


            ],
          ),
        )



      ],
    );
  }
}