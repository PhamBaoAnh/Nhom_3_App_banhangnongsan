import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/t_circular_icon.dart';

class TProductQuantityRemoveButton extends StatelessWidget {
  const TProductQuantityRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: TSizes.md,
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
          color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.black,
          onPressed: remove,
        ),
        const SizedBox(width: TSizes.spaceBtwItems ),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall,),
        const SizedBox(width: TSizes.spaceBtwItems ),
         TCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: TSizes.md,
            backgroundColor:  TColors.primary,
            color:  TColors.white,
            onPressed: add,
        ),
      ],
    );
  }
}