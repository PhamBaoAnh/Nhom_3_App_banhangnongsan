import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants/enums.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculatorSalePercentage(product.price, product.salePrice);
    final variationController = Get.put(VariationController());


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
                '-$salePercentage%',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),
              ),
            ),



            /*
            if (product.price > 0)
              Obx(() => Text(
                '\$${variationController.selectedVariation.value.price}',
                style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
              )),
            */
            const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: controller.getProductPrice(product), isLarge: true),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),
        TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        Row(
          children: [
            const TProductTitleText(title: 'Trạng Thái'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Obx(() => Text(
              variationController.variationStockStatus.value,
              style: Theme.of(context).textTheme.titleMedium,
            )),
          ],
        ),
      ],
    );
  }
}
