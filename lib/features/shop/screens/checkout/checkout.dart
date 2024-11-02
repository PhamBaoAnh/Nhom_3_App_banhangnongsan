
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:project/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:project/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/image_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../common/widgets/products/cart/coupon.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/navigation_menu.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar( showBackArrow: true, title: Text('Thanh Toán', style: Theme.of(context).textTheme.headlineSmall,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
             children: [
               const TCartItems(showAddRemoveButton: false,),
               const SizedBox(height: TSizes.spaceBtwSections,),

               const TCouponCode(),
               const SizedBox(height: TSizes.spaceBtwSections,),

               TRoundedContainer(
                 showBorder: true,
                 backgroundColor: dark ? TColors.black : TColors.white,
                 child: const Column(
                   children: [

                     TBillingAmountSection(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                     Divider(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                     TBillingPaymentSection(),
                     SizedBox(height: TSizes.spaceBtwItems,),

                     TBillingAddressSection(),


                   ],
                 ),

               )


             ],
          ),

        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => SuccessScreen(
            image: TImages.successfulPaymentIcon,
            title: 'Thanh toán thành công',
            subtitle: 'Đơn hàng của bạn sẽ được vận chuyển sớm',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          )),
          style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary)
          ),
          child: const Text('Check out \500.000 VND' ),
        ),
      ),

    );
  }
}


