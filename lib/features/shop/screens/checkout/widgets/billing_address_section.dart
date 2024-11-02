import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(title: 'Địa Chỉ', buttonTitle: 'Thay đổi', onPressed: (){}, textColor: TColors.black,),
        Text('Phạm Bảo Anh', style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),
        Row(
          children: [
            const Icon(Icons.phone, color: TColors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text('0123456789', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),
        Row(
          children: [
            const Icon(Icons.location_history, color: TColors.grey,size: 16,),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Expanded(child: Text('Số 12, Chùa Bộc, Đống Đa, Hà Nội', style: Theme.of(context).textTheme.bodyMedium,)),
          ],
        ),





      ],
    );
  }
}
