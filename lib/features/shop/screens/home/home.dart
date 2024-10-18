
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:project/features/shop/screens/home/widgets/home_categories.dart';
import 'package:project/features/shop/screens/home/widgets/promo_slider.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/circular_container.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/curved_edges/curved_edges.dart';
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart_menu_icon.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [

                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections,),

                  TSearchContainer(text: 'Tìm kiếm'),
                  SizedBox(height: TSizes.spaceBtwSections,),


                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                         TSectionHeading(title: 'Danh mục phổ biến', textColor: TColors.white,),
                         SizedBox(height: TSizes.spaceBtwItems,),

                         THomeCategories()
                      ],
                    ),

                  ),
                ],
              ),
            ),
            //
            //
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(banners: [TImages.promoBanner2,TImages.promoBanner2,TImages.promoBanner2,],),
                  const SizedBox(height: TSizes.spaceBtwSections,),

                  TSectionHeading(title: 'Sản phẩm bán chạy', onPressed: (){}, textColor: TColors.dark,  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  TGridLayout(itemCount: 4, itemBuilder: (_, index) => const TProductCardVertical() ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
























