import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/checkout_controller.dart';
import '../../../models/order_model.dart';

class TBillingPaymentOrder extends StatelessWidget {
  const TBillingPaymentOrder({super.key, required this.orderDetail});


  final OrderModel orderDetail;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());


    final String image = orderDetail.paymentMethod == 'Thanh toán khi nhận hàng'
        ? TImages.cod
        : TImages.vnpay;

    return Column(
      children: [
        const TSectionHeading(
          title: 'Phương thức',
          textColor: TColors.black,
          showActionButton: false,
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 60,
                backgroundColor: dark ? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems / 2), // Fixed alignment here
              Text(
                orderDetail.paymentMethod,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
      ],
    );
  }
}
