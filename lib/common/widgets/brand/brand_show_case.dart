import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/features/shop/models/category_model.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/rounded_container.dart';
import '../images/t_rounded_image.dart';
import 'brandcard.dart';
class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({
    super.key,
    required this.images,
    required this.category, required this.brand,
  });

  final BrandModel brand;
  final CategoryModel category;
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
          // Use the categoryId inside TBrandCard
          TBrandCard(showBorder: false, brand: brand, categoryId: category.id),

          Row(
            children: images.map((image) => brandTopProductImageWidget(image, context)).toList(),
          )
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.white,
        margin: const EdgeInsets.only(right: TSizes.sm),
        padding: const EdgeInsets.all(TSizes.xsm),
        child:  TRoundedImage(imageUrl: image,applyImageRadius: true,isNetworkImage: true,backgroundColor: TColors.white,),

      ),
    );
  }
}
