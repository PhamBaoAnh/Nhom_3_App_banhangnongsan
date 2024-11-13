import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/icons/t_circular_icon.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/navigation_menu.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () {
              final NavigationController controller = Get.find<NavigationController>();
              controller.selectedIndex.value = 0; // Đặt về trang Home
              Get.to(() => const NavigationMenu());
            },
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace),
          child: Column(
            children: [
             /* TGridLayout(
                itemCount: 2,
                itemBuilder: (_, index) => const TProductCardVertical(),
              ),  */
            ],
          ),
        ),
      ),
    );
  }
}
