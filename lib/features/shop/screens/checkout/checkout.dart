
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
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
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/navigation_menu.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final total = TPricingCalculator.calculateTotalPrice(subTotal, 'VN');
    final orderController = Get.put(OrderController());

    return Scaffold(
      appBar: TAppBarBack( showBackArrow: true, title: Text('Thanh Toán', style: Theme.of(context).textTheme.headlineSmall,),),
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
          onPressed: subTotal > 0
              ? () => orderController.processOrder(double.parse(total))
              : () {
            TLoaders.warningSnackBar(
              title: 'Giỏ hàng trống',
              message: 'Hãy thêm sản phẩm vào giỏ hàng ngay nào !!',
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: TColors.primary,
            side: const BorderSide(color: TColors.primary),
          ),

          child: Text(
            'Thanh toán ${NumberFormat.decimalPattern('vi').format(double.parse(TPricingCalculator.calculateTotalPrice(subTotal, 'VN')))} VND',
          ),

        ),
      ),

    );
  }
}


