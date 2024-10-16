import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/screens/signup/widgrts/term_condition_textbox.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,

  });
  @override
  Widget build(BuildContext context) {

    return Form(child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: TTexts.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
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
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.username,
            prefixIcon: Icon(Iconsax.user_edit),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.email,
            prefixIcon: Icon(Iconsax.direct),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          expands: false,
          decoration: const InputDecoration(
            labelText: TTexts.phoneNo,
            prefixIcon: Icon(Iconsax.call),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: TTexts.password,
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon:Icon(Iconsax.eye_slash),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        TTermAndConditionTextBox(),
        const SizedBox(height: TSizes.spaceBtwSections),
        SizedBox(width: double.infinity,
          child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                TTexts.createAccount,
              )
          ),
        ),

      ],
    ));
  }
}
