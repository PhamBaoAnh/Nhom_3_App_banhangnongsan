import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder:  (_, __) => const SizedBox(height: TSizes.spaceBtwItems,),
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                
                Icon(Iconsax.ship),
                SizedBox(width: TSizes.spaceBtwItems /2 ,),
      
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đang xử lý',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.primary, fontWeightDelta: 1 ),
                      ),
                      Text('02/11/2024', style: Theme.of(context).textTheme.headlineSmall,)
                  
                    ],
                  ),
                ),
              IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm,))
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems /2 ,),

            Row(
              children: [
                Expanded(
                    child: Row(
                      children: [
      
                        Icon(Iconsax.tag),
                        SizedBox(width: TSizes.spaceBtwItems /2 ,),
      
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Oder',
                                style: Theme.of(context).textTheme.labelMedium,),
      
                              Text('#123', style: Theme.of(context).textTheme.titleMedium,)
      
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                SizedBox(width: TSizes.spaceBtwItems  ,),
      
                Expanded(
                  child: Row(
                    children: [
      
                      Icon(Iconsax.calendar),
                      SizedBox(width: TSizes.spaceBtwItems /2 ,),
      
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày vận chuyển',
                              style: Theme.of(context).textTheme.labelMedium,),
      
                            Text('5/11/2024', style: Theme.of(context).textTheme.titleMedium,)
      
                          ],
                        ),
                      ),
                    ],
                  ),
                )
      
              ],
            )
      
      
      
      
          ],
        ),
      ),
    );
  }
}
