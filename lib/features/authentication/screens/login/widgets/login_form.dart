import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/repository/user_repo/user_repo.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/navigation_menu.dart';
import '../../../controllers.onboarding/login_controller.dart';
import '../../password_configuration/forgot_password.dart';
import '../../signup/signup.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _loginformKey = GlobalKey<FormState>();
    final loginController = Get.find<LoginController>();
    final storage= GetStorage();
    final showPassword =false.obs;
    final remember =true.obs;
    loginController.email.text = storage.read('email') ?? '';
    loginController.password.text = storage.read('password') ?? '';
    remember.value = storage.read('remember') ?? false;
    return Form(
      key: _loginformKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Obx(()=>TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: !showPassword.value,
            controller: controller.password,
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon:
                IconButton(onPressed: (){
                  showPassword.value=! showPassword.value;
                }, icon: Icon(showPassword.value ? Iconsax.eye :Iconsax.eye_slash))
            ),
          ),),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          // Remember Me and Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                 Obx(()=> Checkbox(value: remember.value, onChanged: (value) {
                   remember.value= !remember.value;

                 }),),
                  const Text(TTexts.rememberMe),
                ],
              ),
              TextButton(
                  onPressed: () => Get.to(() => const ForgotPassword()),
                  child: const Text(TTexts.forgetPassword)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()
                  {
                    if (remember.value) {
                      storage.write('email', loginController.email.text);
                      storage.write('password', loginController.password.text);
                      storage.write('rememberMe', true);
                    } else {
                      storage.remove('email');
                      storage.remove('password');
                      storage.write('rememberMe', false);
                    }

                    String email = controller.email.text.trim();
                    String password = controller.password.text.trim();
                    print( controller.email.text.trim());
                    print( controller.password.text.trim());
                    loginController.login(email, password);
                  },
              child: const Text(TTexts.signIn),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => const SignupScreen()),
              child: const Text(TTexts.createAccount),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
        ],
      ),
    );
  }
}
