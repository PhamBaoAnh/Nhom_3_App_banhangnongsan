import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: TSizes.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: product.productAttributes!.map((attribute) {
            // If the attribute is not selected, set the first value as the default
            if (controller.selectedAttributes[attribute.name] == null && attribute.values.isNotEmpty) {
              controller.selectedAttributes[attribute.name] = attribute.values.first;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TSectionHeading(
                  title: attribute.name,
                  textColor: TColors.dark,
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Obx(() => Wrap(
                  spacing: 10,
                  children: attribute.values.map((attributeValue) {
                    final isSelected = controller.selectedAttributes[attribute.name] == attributeValue;
                    final available = controller
                        .getAttributesAvailabilityInVariation(product.productVariations!, attribute.name)
                        .contains(attributeValue);

                    return TChoiceChip(
                      text: attributeValue,
                      selected: isSelected,
                      onSelected: available
                          ? (selected) {
                        if (selected) {
                          controller.onAttributeSelected(product, attribute.name, attributeValue);
                        }
                      }
                          : null,
                    );
                  }).toList(),
                )),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
