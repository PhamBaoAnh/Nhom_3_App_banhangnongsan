import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
class TProductimageSlider extends StatelessWidget {
  const TProductimageSlider({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.white : TColors.white,
        child: Stack(
          children: [
            const SizedBox(
              height: 450,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 4),
                child: Center(
                  child: Image(image: AssetImage(TImages.productImage2)),
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
                  separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(), // Chỉnh physics để cuộn mượt hơn
                  itemBuilder: (_, index) => TRoundedImage(
                    width: 90,
                    backgroundColor: dark ? TColors.white : TColors.white,
                    border: Border.all(color: TColors.primary),
                    imageUrl: TImages.productImage2,
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
