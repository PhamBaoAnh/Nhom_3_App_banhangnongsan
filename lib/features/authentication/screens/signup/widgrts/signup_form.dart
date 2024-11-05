import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/signup/widgrts/term_condition_textbox.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final formKey = GlobalKey<FormState>();
    final showPassword = false.obs;
    return Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter your first name.'
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              controller: controller.username,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter user name.';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              expands: false,
              decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              controller: controller.email,
              expands: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!emailRegex.hasMatch(value)) {
                  return 'Email is not valid.';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: TTexts.email,
                prefixIcon: Icon(Iconsax.direct),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextFormField(
              controller: controller.phoneNo,
              expands: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone.';
                }
                final phoneRegex = RegExp(r'^\+84\d{9,10}$');
                if (!phoneRegex.hasMatch(value)) {
                  return 'Phone is not valid.';
                }
                return null; // Email hợp lệ
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                labelText: TTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Obx(() => TextFormField(
                  controller: controller.password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length <= 6) {
                      return 'Your password must be more than 6 characters.';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: showPassword.value,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () {
                          showPassword.value = !showPassword.value;
                        },
                        icon: Icon(showPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                    errorStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                )),
            const SizedBox(height: TSizes.spaceBtwSections),
            const TTermAndConditionTextBox(),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        controller.agree.value) {
                      final userModel = UserModel(
                          id : '',
                          gender: '',
                          dateOfBirth: '',
                          firstName: controller.firstName.text.trim(),
                          lastName: controller.lastName.text.trim(),
                          username: controller.username.text.trim(),
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          phoneNo: controller.phoneNo.text.trim());
                      SignupController.instance.createUser(userModel);
                    } else {
                      Get.snackbar('Warning', 'You must agree to continue.');
                    }
                  },
                  child: const Text(
                    TTexts.createAccount,
                  )),
            ),
          ],
        ));
  }
}
