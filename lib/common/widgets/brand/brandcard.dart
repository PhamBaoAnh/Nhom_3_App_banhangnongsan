
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/features/shop/models/product_model.dart';


import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/rounded_container.dart';

import '../images/t_circular_image.dart';


/// A card widget representing a brand.
// class TBrandCard extends StatelessWidget {
//   /// Default constructor for the TBrandCard.
//   ///
//   /// Parameters:
//   ///   - brand: The brand model to display.
//   ///   - showBorder: A flag indicating whether to show a border around the card.
//   ///   - onTap: Callback function when the card is tapped.
//
//   final bool showBorder;
//   final void Function()? onTap;
//   const TBrandCard({super.key, required this.showBorder, this.onTap, required this.nameBrand, this.category});
//   final String nameBrand;
//   final String? category;
//   @override
//   Widget build(BuildContext context) {
//     final isDark = THelperFunctions.isDarkMode(context);
//     final controller =Get.put(BrandController());
//     final controllerProduct =Get.put(ProductController());
//     if(category!=null) {final count =controllerProduct.getProductsByCategoryAndBrand(category!, nameBrand);
//  }
//     return GestureDetector(
//       onTap: onTap,
//       /// Container Design
//       child: TRoundedContainer(
//         showBorder: showBorder,
//         backgroundColor: Colors.transparent,
//         padding: const EdgeInsets.all(TSizes.sm),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// -- Icon
//             Flexible(
//               child: TCircularImage(
//                 image: TImages.google,
//                 isNetworkImage: false,
//                 backgroundColor: Colors.transparent,
//                 overlayColor: isDark ? TColors.white : TColors.primary,
//               ),
//             ),
//             const SizedBox(width: TSizes.spaceBtwItems / 2),
//
//             /// -- Texts
//             // [Expanded] & Column [MainAxisSize.min] is important to keep the elements in the vertical center and also
//             // to keep text inside the boundaries.
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                    TBrandTitleWithVerifidedIcon(title: nameBrand, brandTextSize: TextSizes.large),
//
//                   FutureBuilder<dynamic>(
//                     future: category==null ? controller.getBrandsByName(nameBrand) : controllerProduct.getProductsByCategoryAndBrand(category!, nameBrand),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//
//                         return const CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else if (!snapshot.hasData || snapshot.data == null) {
//                         return const Text('0 product');
//                       }
//                         BrandModel brand = snapshot.data!;
//                       print(brand);
//                         return Text(category==null?
//                           '${brand.productCount ?? 0} products': '$brand',
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.labelMedium,
//                         );
//
//                     },
//                   )
//
//
//
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class TBrandCard extends StatelessWidget {
  final bool showBorder;
  final void Function()? onTap;
  final String? category;
  final BrandModel brand;
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    this.category, required this.brand
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(BrandController());
    final controllerProduct = Get.put(ProductController());

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,

              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifidedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  FutureBuilder<dynamic>(
                    future: category == null
                        ? controller.getBrandsByName(brand.name)
                        : controllerProduct.getProductsByCategoryAndBrand(category!, brand.name),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('0 products');
                      }

                      // Handle the response based on the snapshot data
                      if (category == null) {
                        // Brand model expected for brand count
                        BrandModel brand = snapshot.data!;
                        return Text(
                          '${brand.productCount ?? 0} products',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      } else {
                        // Handle category-specific product count or data
                        var count = snapshot.data; // This may be a list or count

                        return Text(
                          '$count products',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
