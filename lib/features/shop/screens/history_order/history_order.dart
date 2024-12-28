import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/features/shop/models/order_model.dart';
import 'package:project/features/shop/screens/history_order/widgets/address_history_order.dart';
import 'package:project/features/shop/screens/history_order/widgets/billing_history_order.dart';
import 'package:project/features/shop/screens/history_order/widgets/cart_history_order.dart';
import 'package:project/features/shop/screens/history_order/widgets/payment_history_order.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/appbar_back.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/product/cancel_order_controller.dart';
import '../cart/widgets/cart_items.dart';
import '../checkout/widgets/billing_address_section.dart';
import '../checkout/widgets/billing_amount_section.dart';
import '../checkout/widgets/billing_payment_section.dart';

class THistoryOrders extends StatelessWidget {
  const THistoryOrders( {super.key, required this.orderDetail});

  final OrderModel  orderDetail;


  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
     /*  final controller = Get.put(CanCelOrderController());  */


    return Scaffold(
      appBar: TAppBarBack(showBackArrow: true,actions: [], title: Text('Chi tiết hóa đơn',style: Theme.of(context).textTheme.headlineSmall,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    TCartHisToryOrder(showAddRemoveButton: false, orderDetail: orderDetail,),
                    const SizedBox(height: TSizes.spaceBtwSections,),
                    const Divider(),

                    TBillingHistoryOrder(orderDetail: orderDetail),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    TBillingPaymentOrder(orderDetail: orderDetail),
                    const SizedBox(height: TSizes.spaceBtwItems,),

                    TAddressHistoryOrder (orderDetail: orderDetail),
                  ],

                ),


              ),

/*
              const SizedBox(height: TSizes.spaceBtwSections),
              if (orderDetail.orderStatusText == 'Đang chờ xác nhận')
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final confirm = await Get.dialog<bool>(
                        AlertDialog(
                          title: const Text('Xác nhận hủy đơn hàng'),
                          content: const Text('Bạn chắc chắn muốn hủy đơn hàng này không?'),
                          actions: [
                            TextButton(onPressed: () => Get.back(result: false), child: const Text('Hủy')),
                            TextButton(onPressed: () => Get.back(result: true), child: const Text('Đồng ý')),
                          ],
                        ),
                      );

                      if (confirm == true && orderDetail.id.isNotEmpty) {
                        try {
                          await controller.cancelOrderById(orderDetail);
                        } catch (e) {
                          // Handle the error silently or log it as needed
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      side: const BorderSide(color: TColors.primary),
                    ),
                    child: const Text('Hủy Đơn Hàng'),
                  ),
                ),

*/

            ],
          ),

        ),
      ),
    );

  }
}
