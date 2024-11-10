import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/icons/t_circular_icon.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/features/shop/screens/store/widgets/category_tab.dart';
import 'package:project/utils/constants/enums.dart';
import 'package:project/utils/constants/image_strings.dart';
import 'package:project/utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
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

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.allCategories;
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
                        onPressed: () {},
                        textColor: TColors.black,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                      
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index ) {
                        return const TBrandCard(showBorder: false,);
                      },)
                    ],
                  ),
                ),
      
      
              bottom: TTabBar(
                  /*
                  tabs: [
                Tab(child: Text('Nhật Bản')),
                Tab(child: Text('Viêt Nam')),
                Tab(child: Text('Hàn Quốc')),
                Tab(child: Text('Trung Quốc')),
                Tab(child: Text('Mỹ'))

              ]  */
                tabs: categories.map((category) => Tab(child: Text(category.name)) ).toList(),



              ),
              ),
            ];
          },
          body: TabBarView(
              children: [

                ...categories.map((category) => TCategoryTab(category: category))
                /*
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                */

              ]

          ),
        ),
      ),
    );
  }
}

