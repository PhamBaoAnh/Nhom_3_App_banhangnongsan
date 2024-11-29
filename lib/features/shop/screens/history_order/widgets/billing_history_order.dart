import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/pricing_calculator.dart';
import '../../../controllers/product/cart_controller.dart';
import '../../../models/order_model.dart';

class TBillingHistoryOrder extends StatelessWidget {
  const TBillingHistoryOrder ({super.key, required this.orderDetail});

  final OrderModel orderDetail;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwItems / 2,),
        Row(

          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Thanh Toán', style: Theme.of(context).textTheme.bodyMedium,),
            Text('${NumberFormat.decimalPattern('vi').format(double.parse(orderDetail.totalAmount.toString()))} VND' , style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Ngày Đặt Hàng', style: Theme.of(context).textTheme.bodyMedium,),
            Text( DateFormat('dd/MM/yyyy').format(orderDetail.orderDate), style: Theme.of(context).textTheme.bodyMedium,),

    ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2,),

        Row(
          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
          children: [

            Text('Trạng Thái', style: Theme.of(context).textTheme.bodyMedium,),
            Text( orderDetail.orderStatusText, style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),


      ],
    );
  }
}
