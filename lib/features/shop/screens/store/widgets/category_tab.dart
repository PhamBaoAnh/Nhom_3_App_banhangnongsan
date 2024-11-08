
import 'package:flutter/material.dart';
import 'package:project/features/shop/models/category_model.dart';

import '../../../../../common/widgets/brand/brand_show_case.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab ({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [

              const TBrandShowcase(images: [TImages.productImage2,TImages.productImage2,TImages.productImage2],),

              TSectionHeading(
                title: 'Quốc Gia',
                showActionButton: true,
                onPressed: () {},
                textColor: TColors.black,
              ),
              const SizedBox(height: TSizes.spaceBtwItems ),
              TGridLayout(itemCount: 4,itemBuilder: (_, index) => const TProductCardVertical(),),
            ],
          ),
        )
      ],
    );
  }
}

