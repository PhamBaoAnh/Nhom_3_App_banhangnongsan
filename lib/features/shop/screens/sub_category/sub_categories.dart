import 'package:flutter/material.dart';
import 'package:project/utils/constants/image_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('Danh Mục'),showBackArrow: true, ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /* const TRoundedImage(width: double.infinity,image: TImages.promoBanner2,applyImageRadius: true,), */
              const SizedBox(height: TSizes.spaceBtwSections),

             Column(
               children: [
                 TSectionHeading(title: 'Danh mục 1',onPressed: (){}, textColor: Colors.black,),
                 const SizedBox(height: TSizes.spaceBtwSections  ),


                 SizedBox(
                   height: 120,
                   child: Align(

                     child: ListView.separated(
                       itemCount: 4,
                       scrollDirection: Axis.horizontal,
                       separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems * 3),
                       itemBuilder: (context, index) => const TProductCardHorizontal(),
                     ),
                   ),
                 ),



               ],
             )
            ],
          ),
        ),
      ),

    );
  }
}
