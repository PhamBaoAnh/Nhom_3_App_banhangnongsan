import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/icons/t_circular_icon.dart';

import '../../../../common/widgets/animation/animation_loader.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/navigation_menu.dart';
import '../../controllers/product/favourites_controller.dart';
import '../../models/product_model.dart';
import '../home/home.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
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
              controller.selectedIndex.value = 0; // Set to Home page
              Get.to(() => const NavigationMenu());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: TSizes.defaultSpace),
          child: Obx(
                () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Return a loading state or spinner if needed
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return TAnimationLoaderWidget(
                    text: 'Thêm sản phẩm yêu thích của bạn ngay nào !!',
                    animation: TImages.pencilAnimation,
                    showAction: true,
                    actionText: 'Thêm tiếp nào !',
                    onActionPressed: () {
                      final NavigationController controller = Get.find<NavigationController>();
                      controller.selectedIndex.value = 0; // Set to Home page
                      Get.to(() => const NavigationMenu());
                    },
                  );
                }

                return TGridLayout(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => TProductCardVertical(
                    product: snapshot.data![index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
