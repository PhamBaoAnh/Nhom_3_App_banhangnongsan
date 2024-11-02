import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Tổng Tiền', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\456.000 VND', style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Phí Vận Chuyển', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\10.000 VND', style: Theme.of(context).textTheme.labelLarge,),

          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Thanh Toán', style: Theme.of(context).textTheme.bodyMedium,),
            Text('\466.000 VND', style: Theme.of(context).textTheme.titleMedium,),

          ],
        ),


      ],
    );
  }
}
