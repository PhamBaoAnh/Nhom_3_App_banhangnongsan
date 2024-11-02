import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(title: 'Thanh toán', buttonTitle: 'Thay đổi', onPressed: (){}, textColor: TColors.black,),

        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 60,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImages.vnpay), fit: BoxFit.contain,),
            ),

            const SizedBox(height: TSizes.spaceBtwItems / 2,),
            Text('VNPay', style: Theme.of(context).textTheme.bodyLarge,)

          ],
        )

      ],
    );
  }
}
