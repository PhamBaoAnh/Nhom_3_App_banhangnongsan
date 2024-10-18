import 'package:flutter/material.dart';
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/image_strings.dart';
import 'package:project/utils/device/device_utility.dart';
import 'package:project/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controllers.onboarding/onboarding_controller.dart';


class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 20,
      left: 0,  // Không cần thiết nữa vì đã sử dụng Align
      right: 0, // Để nó căn giữa theo chiều ngang
      child: Align(
        alignment: Alignment.center, // Căn giữa SmoothPageIndicator
        child: SmoothPageIndicator(
          controller: controller.pageController,
          count: 3,
          onDotClicked: controller.doNavigationClick,
          effect: ExpandingDotsEffect(
            activeDotColor: dark ? TColors.light : TColors.dark,
            dotHeight: 6,
          ),
        ),
      ),
    );
  }
}
