import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../../features/authentication/screens/login/login.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/spacing_styles.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subtitle, required this.onPressed});

  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight * 2,
            child: Column(
              children: [
                Lottie.asset(image, width: MediaQuery.of(context).size.width * 0.8),
                const SizedBox(height: TSizes.spaceBtwSections),

                Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems),
                 /* Text(title, style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwItems), */
                Text(subtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
                const SizedBox(height: TSizes.spaceBtwSections),

                SizedBox(width: double.infinity,
                  child: ElevatedButton(
                      onPressed:  onPressed ,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.primary,
                      side: const BorderSide(color: TColors.primary),
                    ),
                      child: const Text(
                        TTexts.tContinue,
                      ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
