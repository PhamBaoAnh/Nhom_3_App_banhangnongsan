import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TButtonAddToCart extends StatelessWidget {
  const TButtonAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
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
         Row(
           children: [
             const TCircularIcon(
               icon: Iconsax.minus,
               backgroundColor: TColors.primary,
               width: 40,
               height: 40,
               color: TColors.white,
             ),
             const SizedBox(width: TSizes.spaceBtwItems ,),
             Text('2', style: Theme.of(context).textTheme.titleSmall,),
             const SizedBox(width: TSizes.spaceBtwItems ,),
             const TCircularIcon(
               icon: Iconsax.add,
               backgroundColor: TColors.primary,
               width: 40,
               height: 40,
               color: TColors.white,
             ),
           ],
         ),
         ElevatedButton(
           onPressed: (){},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary)
            ),
           child: const Text('Thêm vào giỏ hàng'),

           ),
        ],
      ),

    );
  }
}
