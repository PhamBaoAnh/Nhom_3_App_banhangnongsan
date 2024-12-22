import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/icons/t_circular_icon.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/features/shop/controllers/product/brand_controller.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/screens/store/widgets/category_tab.dart';
import 'package:project/utils/constants/enums.dart';
import 'package:project/utils/constants/image_strings.dart';
import 'package:project/utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brand/brand_products.dart';
import '../../../../common/widgets/brand/brand_show_case.dart';
import '../../../../common/widgets/brand/brandcard.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/containers/search_container.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/category_controller.dart';
import '../brand/all_brands.dart';

import 'package:flutter/services.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProductController());
    final categories = CategoryController.instance.allCategories;
    final brandController = Get.put(BrandController());

    // Preload brands
    final Future<List<dynamic>> brandsFuture = brandController.getAllBrands();

    return FutureBuilder(
      future: brandsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final brands = snapshot.data ?? [];
        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            appBar: TAppBar(
              title: Text(
                'Store',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                TCartCounterIcon(
                  onPressed: () {},
                  iconColor: TColors.black,
                  iconColor2: TColors.white,
                )
              ],
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: TSizes.spaceBtwItems),
                          const TSearchContainer(
                            text: 'Tìm kiếm',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          TSectionHeading(
                            title: 'Quốc Gia',
                            showActionButton: true,
                            onPressed: () => Get.to(
                                  () => const AllBrandScreen(),
                              transition: Transition.leftToRightWithFade,
                              duration: const Duration(milliseconds: 600),
                            ),

                            textColor: TColors.black,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                          TGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              return TBrandCard(
                                brand: brands[index],
                                showBorder: true,
                                onTap: () => Get.to(
                                      () => BrandProducts(brand: brands[index]),
                                  transition: Transition.circularReveal,
                                  duration: const Duration(milliseconds: 300),
                                ),

                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    bottom: TTabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList(),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: categories
                    .map(
                      (category) => TCategoryTab(
                    category: category,
                    brand: brands.isNotEmpty ? brands[0] : null,
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

