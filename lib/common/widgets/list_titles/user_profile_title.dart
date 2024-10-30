import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';

import '../../../features/authentication/models/user_model.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';

class TUserProfileTitle extends StatelessWidget {
  TUserProfileTitle({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            ;
            return IconButton(
                onPressed: () {
                  controller.logOut();
                  Get.offAll(() => const LoginScreen());
                },
                icon: const Icon(Iconsax.login, color: TColors.white));
          } else if (snapshot.hasData)  {
            UserModel userdata = snapshot.data!;

            return ListTile(
              leading: const TCircularImage(
                image: TImages.user,
                isNetworkImage: false,
                width: 50,
                height: 50,
                padding: 0, // Áp dụng màu phủ
              ),
              title: Text(AuthenticationRepository.instance.firebaseUser?.displayName ?? '${userdata.firstName} ${userdata.lastName}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: TColors.white))

              ,subtitle: Text(userdata.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: TColors.white)),
              trailing: IconButton(
                  onPressed: onPressed,
                  icon: const Icon(
                    Iconsax.edit,
                    color: TColors.white,
                  )),
            );
          }

          // Handle case where snapshot is empty
          return const Center(child: Text('No data found'));
        });
  }
}
