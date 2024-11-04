import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/brand/brand_products.dart';
import '../../../../common/widgets/brand/brandcard.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/sortable/sortbale_products.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar( showBackArrow: true, title: Text('Brand'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [

              const TSectionHeading(title: 'Brand',textColor: TColors.black,showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems,),

              TGridLayout(itemCount: 10,mainAxisExtent: 80,itemBuilder: (context, index) => TBrandCard(showBorder: true, onTap: () => Get.to(() => const BrandProducts()) ,),)

            ],
          ),


        ),
      ),


    );
  }
}
