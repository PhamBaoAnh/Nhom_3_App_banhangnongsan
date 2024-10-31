import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/rounded_container.dart';
import 'brandcard.dart';
class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: TColors.white,
      padding: const EdgeInsets.all(TSizes.sm),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          //
          const TBrandCard(showBorder: false),

          Row(
            children: images.map((images) => brandTopProductImageWidget(images, context)).toList(),
          )

        ],
      ),
    );
  }
  Widget brandTopProductImageWidget(String image, context ){
    return Expanded(
      child: TRoundedContainer(
          height: 100,
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.white,
          margin: const EdgeInsets.only(right: TSizes.sm),
          padding: const EdgeInsets.all(TSizes.xsm),
          child:  Image(fit: BoxFit.contain, image: AssetImage(image),)
      ),
    );
  }


}

