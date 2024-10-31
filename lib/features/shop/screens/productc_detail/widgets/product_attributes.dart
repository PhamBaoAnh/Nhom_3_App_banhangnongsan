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
class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: TSizes.spaceBtwItems ,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Khối Lượng', textColor: TColors.dark,showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems ,),
            Wrap(
              spacing: 10,
              children: [
                TChoiceChip(text: '1 Kg',selected: true, onSelected: (value){},),
                TChoiceChip(text: '1.5 Kg',selected: false,onSelected: (value){},),
                TChoiceChip(text: '2 Kg',selected: false,onSelected: (value){},),
                TChoiceChip(text: '3 Kg',selected: false,onSelected: (value){},),
              ],
            ),

          ],
        )

      ],
    );
  }
}