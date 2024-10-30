
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/controllers.onboarding/login_controller.dart';
import 'package:project/features/authentication/screens/login/login.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
//
// class TSocialButtons extends StatelessWidget {
//   const TSocialButtons({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LoginController());
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: TColors.grey),
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: IconButton(
//               onPressed:(){
//                 controller.loginWithGoogle();
//               },
//               icon: const Image(
//                 width: TSizes.iconMd,
//                 height: TSizes.iconMd,
//                 image: AssetImage(TImages.google),
//               ),
//             )
//         ),
//         const SizedBox(width: TSizes.spaceBtwItems),
//         Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: TColors.grey),
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: IconButton(
//               onPressed:(){
//                 controller.loginWithFacebook();
//               },
//               icon: const Image(
//                 width: TSizes.iconMd,
//                 height: TSizes.iconMd,
//                 image: AssetImage(TImages.facebook),
//               ),
//             )
//         ),
//
//       ],
//     );
//   }
// }
class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  controller.loginWithGoogle();
                },
                icon: controller.isGoogleLoading.value
                    ? const SizedBox(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  child: CircularProgressIndicator(),
                )
                    : const Image(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  image: AssetImage(TImages.google),
                ),
              ),
            )),
            const SizedBox(width: TSizes.spaceBtwItems),
            Obx(() => Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: () {
                  controller.loginWithFacebook();
                },
                icon: controller.isFacebookLoading.value
                    ? const SizedBox(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  child: CircularProgressIndicator(),
                )
                    : const Image(
                  width: TSizes.iconMd,
                  height: TSizes.iconMd,
                  image: AssetImage(TImages.facebook),
                ),
              ),
            )),
          ],
        ),
        const SizedBox(height: 16.0), // Add some spacing

      ],
    );
  }
}
