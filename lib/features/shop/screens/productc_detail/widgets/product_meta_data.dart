import 'package:flutter/material.dart';
import 'package:project/utils/constants/enums.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TRoundedContainer(
            radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '-24%',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),

              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems,),

            Text('\200.000 VND', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            const SizedBox(width: TSizes.spaceBtwItems,),
            const TProductPriceText(price: '150.000', isLarge: true,),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),

        const TProductTitleText(title: 'Cherry Mỹ nhập khẩu ', ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          children: [
            const TProductTitleText(title: 'Trạng Thái',),
            const SizedBox(width: TSizes.spaceBtwItems ,),
            Text('Còn hàng', style: Theme.of(context).textTheme.titleMedium,),

          ],
        ),
        /*
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        const TBrandTitleWithVerifidedIcon(title: 'Việt Nam', brandTextSize: TextSizes.large,),
        */
      ],
    );
  }
}
