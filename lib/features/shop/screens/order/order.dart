import 'package:flutter/material.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/features/shop/screens/order/widgets/orders_list.dart';
import 'package:project/utils/constants/sizes.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TAppBar(title: Text('Đơn Hàng', style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true, ),

      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: TOrdersListItems(),

      ),


    );
  }
}
