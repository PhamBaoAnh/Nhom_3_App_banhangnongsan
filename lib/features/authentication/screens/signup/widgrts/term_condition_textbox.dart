import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TTermAndConditionTextBox extends StatelessWidget {
  const TTermAndConditionTextBox({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    final controller  =Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(()=>Checkbox(
              value: controller.agree.value,
              onChanged: (value){
                controller.agree.value= !controller.agree.value;
              }),
          ),),
        const SizedBox(width: TSizes.spaceBtwItems),

        Text.rich(
          TextSpan(
            children: [
              TextSpan(text:   '${TTexts.iAgreeTo } ',  style:  Theme.of(context).textTheme.bodySmall),
              TextSpan(text:   '${TTexts.privacyPolicy } ',  style:  Theme.of(context).textTheme.bodyMedium!.apply(
                decoration: TextDecoration.underline,
                color: dark ? TColors.white : TColors.primary,
                decorationColor: dark ? TColors.white : TColors.primary,

              )),
              TextSpan(text:  '${ TTexts.and  } ',  style:  Theme.of(context).textTheme.bodySmall),
              TextSpan(text:   '${TTexts.termsOfUse } ',  style:  Theme.of(context).textTheme.bodyMedium!.apply(
                decoration: TextDecoration.underline,
                color: dark ? TColors.white : TColors.primary,
                decorationColor: dark ? TColors.white : TColors.primary,

              )),
            ],
          ),
        ),

      ],
    );
  }
}