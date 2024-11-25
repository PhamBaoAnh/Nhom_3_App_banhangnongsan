import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../controllers/product/cart_controller.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection ({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;


    return Column(
      children: [
        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Tổng Tiền', style: Theme.of(context).textTheme.bodyMedium,),
            Text('${NumberFormat.decimalPattern('vi').format(cartController.totalCartPrice.value)} VND' , style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Phí Vận Chuyển', style: Theme.of(context).textTheme.bodyMedium,),
            Text(
              '${NumberFormat.decimalPattern('vi').format(double.parse(TPricingCalculator.calculateShippingCost(subTotal, 'VN')))} VND',
              style: Theme.of(context).textTheme.labelLarge,
            )


          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Thanh Toán', style: Theme.of(context).textTheme.bodyMedium,),
            Text(
              '${NumberFormat.decimalPattern('vi').format(double.parse(TPricingCalculator.calculateTotalPrice(subTotal, 'VN')))} VND',
              style: Theme.of(context).textTheme.titleMedium,
            )

          ],
        ),


      ],
    );
  }
}
