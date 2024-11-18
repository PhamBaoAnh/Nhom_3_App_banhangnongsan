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

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHeading(title: 'Địa Chỉ', buttonTitle: 'Thay đổi', onPressed: () => addressController.selectNewAddressPopup(context), textColor: TColors.black,),
          addressController.selectedAddress.value.id.isNotEmpty?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.user, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Text( addressController.selectedAddress.value.name, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Icons.phone, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Text(addressController.selectedAddress.value.phoneNumber, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              Row(
                children: [
                  const Icon(Iconsax.location, color: TColors.grey,size: 16,),
                  const SizedBox(width: TSizes.spaceBtwItems,),
                  Expanded(child: Text(addressController.selectedAddress.value.address, style: Theme.of(context).textTheme.bodyMedium,)),
                ],
              ),
            ],

          )
              : Text('Chọn địa chỉ', style: Theme.of(context).textTheme.bodyMedium,),

        ],
      ),
    );
  }
}
