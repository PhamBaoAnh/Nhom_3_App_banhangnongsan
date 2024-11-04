import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/products/sortable/sortbale_products.dart';
import '../../../../utils/constants/sizes.dart';

class AllProduct extends StatelessWidget {
  const AllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: TAppBar( showBackArrow: true, title: Text('Tất cả các sản phẩm', style: Theme.of(context).textTheme.headlineSmall,),),
      body: const SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: TSortableProducts()),
      ),


    );
  }
}

