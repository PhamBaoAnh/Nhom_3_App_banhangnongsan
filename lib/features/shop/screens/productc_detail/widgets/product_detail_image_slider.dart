import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/images_controller.dart';

class TProductimageSlider extends StatelessWidget {
  const TProductimageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.white : TColors.white,
        child: Stack(
          children: [
            SizedBox(
              height: 480,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 4),
                child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: TColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 75,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(
                        () {
                      final imageSelected = controller.selectedProductImage.value == images[index];
                      return TRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        imageUrl: images[index],
                        padding: const EdgeInsets.all(TSizes.sm),
                        backgroundColor: dark ? TColors.white : TColors.white,
                        border: Border.all(color: imageSelected  ? TColors.primary : Colors.transparent),
                        onPressed: ()=> controller.selectedProductImage.value = images[index],
                       
                      );
                    },
                  ),
                ),
              ),
            ),
            const TAppBar(
              showBackArrow: true,
              actions: [
                TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
