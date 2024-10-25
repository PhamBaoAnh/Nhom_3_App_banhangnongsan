import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart';
import 'package:project/features/authentication/screens/signup/widgrts/term_condition_textbox.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../verify_email.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();
    return Form(
        key: _formKey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.firstName,
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(

              child: TextFormField(
                controller: controller.lastName,
                decoration: const InputDecoration(
                  labelText: TTexts.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          controller: controller.username,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.username,
            prefixIcon: Icon(Iconsax.user_edit),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          controller: controller.email,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.email,
            prefixIcon: Icon(Iconsax.direct),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          controller: controller.phoneNo,
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.phoneNo,
            prefixIcon: Icon(Iconsax.call),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          controller: controller.password,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: TTexts.password,
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon:Icon(Iconsax.eye_slash),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),

         const TTermAndConditionTextBox(),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(width: double.infinity,
          child: ElevatedButton(
              onPressed:
                  // () => Get.to(() => const VerifyEmailScreen()),
              (){
                 if(_formKey.currentState!.validate()){
                   SignupController.instance.registerUser(controller.email.text, controller.password.text);
                 }

              },
              child: const Text(
                TTexts.createAccount,
              )
          ),
        ),

      ],
    ));
  }
}

