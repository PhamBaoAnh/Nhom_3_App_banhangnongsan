
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:project/features/shop/screens/home/widgets/home_categories.dart';
import 'package:project/common/widgets/chatbot/messenger.dart';
import 'package:project/features/shop/screens/home/widgets/promo_slider.dart';
import '../../../../common/widgets/animation/animation_page_route_transition.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Stack(
      children: [
        Scaffold(
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
                            TSectionHeading(
                              title: 'Danh mục phổ biến',
                              textColor: TColors.white,
                              showActionButton: false,
                            ),
                            SizedBox(height: TSizes.spaceBtwItems,),
                            THomeCategories(),
                            SizedBox(height: TSizes.spaceBtwSections,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      const TPromoSlider(),
                      const SizedBox(height: TSizes.spaceBtwSections,),

                      TSectionHeading(
                        title: 'Sản phẩm bán chạy',
                        onPressed: () => Navigator.of(context).push(
                          customPageRoute(
                            AllProduct(),
                          ),
                        ),
                        textColor: TColors.dark,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems,),

                      Obx(() {
                        if (controller.featuredProducts.isEmpty) {
                          return const Center(
                            child: Text(
                              "Không có sản phẩm nào",
                              style: TextStyle(color: TColors.primary),
                            ),
                          );
                        }
                        return TGridLayout(
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return TProductCardVertical(
                              product: controller.featuredProducts[index],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Biểu tượng Messenger
        const Positioned(
          bottom: 40, // Cách đáy 20px
          right: 20, // Cách phải 20px
          child: MessengerIcon(),
        ),
      ],
    );
  }
}

























