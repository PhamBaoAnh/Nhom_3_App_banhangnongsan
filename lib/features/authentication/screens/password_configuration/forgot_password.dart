import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/password_reset_email.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:project/repository/user_repo/user_repo.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(PasswordResetEmail());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(TTexts.forgetPassword, style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

           TextFormField(
             controller: controller.email,
             decoration: const InputDecoration(
               labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct),
             ),
           ),

            const SizedBox(height: TSizes.spaceBtwSections ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                       var email =controller.email.text.trim();

                       if (email.isNotEmpty) {
                         controller.sendPasswordResetEmail();
                         Get.off(() =>const ResetPassword());
                       } else {
                         Get.snackbar('Error', 'Please enter a valid email');
                       }               } ,
                  child: const Text(TTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
