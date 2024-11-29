import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/animation/animation_loader.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/navigation_menu.dart';
import '../../../controllers/product/order_controller.dart';
import '../../history_order/history_order.dart';

class TOrdersListItems extends StatelessWidget {
  const TOrdersListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);

    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Đã xảy ra lỗi khi tải dữ liệu: ${snapshot.error}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          );
        }

        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return TAnimationLoaderWidget(
            text: 'Whoops! Giỏ hàng của bạn đang trống !!',
            animation: TImages.orderCompletedAnimation,
            showAction: true,
            actionText: 'Đặt hàng ngay nào !',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );
        }

        final orders = snapshot.data! ;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return TRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Order header
                  Row(
                    children: [
                      const Icon(Iconsax.ship),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText, // Tên sản phẩm
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: TColors.black, fontWeightDelta: 1),
                            ),
                            Text(
                              order.address!.name.toString(), // Ngày đặt hàng
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => THistoryOrders( orderDetail:orders[index],)), // Thêm hành động nếu cần
                        icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  // Order details
                  Row(
                    children: [
                      // Order ID
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mã đơn hàng',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id, // ID đơn hàng
                                    style: Theme.of(context).textTheme.titleMedium?.apply(color:TColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),

                      // Shipping date
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ngày đặt hàng',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formatDeliveryDate, // Ngày vận chuyển
                                    style: Theme.of(context).textTheme.titleMedium?.apply(color: TColors.black),

                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
