import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../appbar/appbar.dart';
import '../products/sortable/sortbale_products.dart';
import 'brandcard.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar( title: Text('Brand 1'),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               TBrandCard(showBorder: true,),
               const SizedBox(height: TSizes.spaceBtwSections,),
               TSortableProducts(),

            ],
          ),


        ),

      ),

    );
  }
}

