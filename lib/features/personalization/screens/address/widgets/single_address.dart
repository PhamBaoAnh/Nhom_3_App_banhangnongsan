import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final isSelected = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent, // Remove the highlight effect
        splashColor: Colors.transparent,    // Remove the splash effect
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: isSelected ? TColors.primary.withOpacity(0.2) : Colors.transparent,
          borderColor: isSelected
              ? Colors.transparent
              : dark
              ? TColors.darkGrey
              : TColors.grey,
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  Text(
                    address.address,
                    softWrap: true,
                  ),
                ],
              ),
              if (isSelected)
                Positioned(
                  right: 20,  // Adjusted position for the check icon
                  top: 0,      // Adjusted position for the check icon
                  child: Icon(
                    Iconsax.tick_circle5,
                    color: dark ? TColors.light : TColors.primary,
                  ),
                ),
              Positioned(
                right: -3, // Adjusted position for the trash icon
                bottom: -3,  // Adjusted position for the trash icon
                child: IconButton(
                  icon: const Icon(
                    Iconsax.trash,
                    color: TColors.darkerGrey, // Replace with your color
                  ),
                  onPressed: () => showConfirmDeleteDialog(context, address.id),
                  tooltip: "Delete address",
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showConfirmDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: const Text('Bạn có chắc chắn muốn xóa địa chỉ này không?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Đóng dialog nếu người dùng chọn "Hủy"
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                // Xóa địa chỉ nếu người dùng chọn "Xóa"
                await AddressController.instance.deleteAddress(id);
                Navigator.of(context).pop(); // Đóng dialog sau khi xóa
              },
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }
}
