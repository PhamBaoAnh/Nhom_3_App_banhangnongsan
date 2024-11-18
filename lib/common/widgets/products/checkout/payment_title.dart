import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/shop/controllers/product/checkout_controller.dart';
import '../../../../features/shop/models/payment_method_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../containers/rounded_container.dart';

class TPaymentTitle extends StatelessWidget {
  const TPaymentTitle({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Update selected payment method
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back(); // Close the bottom sheet
      },
      leading: TRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Image.asset(
          paymentMethod.image,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(Icons.error), // Fallback for missing images
        ),
      ),
      title: Text(
        paymentMethod.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
