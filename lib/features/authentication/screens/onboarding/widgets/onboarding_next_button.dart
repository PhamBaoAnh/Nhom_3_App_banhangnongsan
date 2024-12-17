import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers.onboarding/onboarding_controller.dart';
class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: OutlinedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: const BorderSide(
            color: TColors.primary, // Màu viền// Độ dày viền
          ),
          backgroundColor: TColors.primary, // Màu nền
          foregroundColor: Colors.white,    // Màu của icon/text
        ),
        child: const Icon(Iconsax.arrow_right_3),
      ),

    );
  }
}
