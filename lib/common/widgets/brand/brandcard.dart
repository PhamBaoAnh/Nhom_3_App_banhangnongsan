import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';
import '../images/t_circular_image.dart';

class TBrandCard extends StatelessWidget {
  final bool showBorder;
  final VoidCallback? onTap;
  final String? categoryId;
  final BrandModel brand;

  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    this.categoryId,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brandController = Get.put(BrandController());
    final productController = Get.put(ProductController());

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand Image
            Flexible(
              child: TCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // Brand Details
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand Title with Verified Icon
                  TBrandTitleWithVerifidedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),

                  FutureBuilder<dynamic>(
                    future: categoryId == null
                        ? brandController.getBrandsByName(brand.name)
                        : productController.getProductsByCategoryAndBrand(
                      categoryId!,
                      brand.name,
                    ),
                    builder: (context, snapshot) {
                       if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Text(
                          '0 products',
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      }

                      if (categoryId == null) {
                        final BrandModel fetchedBrand = snapshot.data!;
                        return Text(
                          '${fetchedBrand.productCount ?? 0} products',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      } else {
                        final int productCount = snapshot.data;
                        return Text(
                          '$productCount products',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
