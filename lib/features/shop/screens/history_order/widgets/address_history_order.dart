import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../personalization/controllers/address_controller.dart';
import '../../../models/order_model.dart';

class TAddressHistoryOrder extends StatelessWidget {
  const TAddressHistoryOrder ({super.key, required this.orderDetail});

  final OrderModel orderDetail;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TSectionHeading(title: 'Địa Chỉ',showActionButton: false, textColor: TColors.black,),
          const SizedBox(height: TSizes.spaceBtwItems / 2,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.user, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Text(orderDetail.address!.name, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Icons.phone, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Text(orderDetail.address!.phoneNumber, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Iconsax.location, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: Text(orderDetail.address!.address, style: Theme.of(context).textTheme.bodyMedium,)),
                ],
              ),
            ],

          )

        ],
    );
  }
}
