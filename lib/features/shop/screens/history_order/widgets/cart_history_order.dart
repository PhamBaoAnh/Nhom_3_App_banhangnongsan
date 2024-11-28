import 'package:flutter/material.dart';
import 'package:get/get.dart';  // Ensure GetX is imported
import 'package:intl/intl.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';
import '../../../models/order_model.dart';

class TCartHisToryOrder extends StatelessWidget {
  const TCartHisToryOrder({
    super.key,
    this.showAddRemoveButton = true,
    required this.orderDetail,
  });

  final bool showAddRemoveButton;
  final OrderModel orderDetail;

  @override
  Widget build(BuildContext context) {
        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
          itemCount: orderDetail.items.length,
          itemBuilder: (_, index) {
            final item = orderDetail.items[index];
            return Column(
              children: [
                TCartItem(cartItem: item),
              ],
            );
          },
        );

  }
}
