import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/login/login.dart';
import 'package:project/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder<dynamic>(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              // Check for connection state and handle loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Check if there was an error
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              // Check if we received data
              if (snapshot.hasData) {
                UserModel userdata = snapshot.data!;
                return _buildProfileContent(userdata);
              }

              // Handle case where snapshot is empty
              return const Center(child: Text('No data found'));
            },
          ),
        ),
      ),
    );
  }

  // A helper method to build profile content
  Widget _buildProfileContent(UserModel userdata) {
    final controller = Get.put(ProfileController());
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(children: [
            const TCircularImage(
              image: TImages.user,
              isNetworkImage: false,
              width: 80,
              height: 80,
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement change profile picture logic
              },
              child: const Text("Change Profile Picture"),
            ),
          ]),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        const TSectionHeading(
          title: 'Thông Tin Tài Khoản',
          showActionButton: false,
          textColor: TColors.black,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        TProfileMenu(
          title: 'Name',
          value: '${userdata.firstName} ${userdata.lastName}',
          onPressed: () {
            // TODO: Implement logic for editing name
          },
        ),
        TProfileMenu(
          title: 'Username',
          value: userdata.username,
          onPressed: () {
            // TODO: Implement logic for editing username
          },
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        const TSectionHeading(
          title: 'Thông Tin Cá Nhân',
          showActionButton: false,
          textColor: TColors.black,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        TProfileMenu(
          title: 'User ID',
          value: '1', // Assuming you have an id field in UserModel
          icon: Iconsax.copy,
          onPressed: () {},
        ),
        TProfileMenu(
          title: 'Email',
          value: userdata.email,
          onPressed: () {},
        ),
        TProfileMenu(
          title: 'Phone Number',
          value: userdata.phoneNo,
          onPressed: () {},
        ),
        TProfileMenu(
          title: 'Gender',
          value: userdata.gender ?? 'defautl',
          // Assuming gender is a field in UserModel
          onPressed: () {},
        ),
        TProfileMenu(
          title: 'Date of Birth',
          value: '21/10/2003', // Assuming dateOfBirth is a field in UserModel
          onPressed: () {},
        ),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                await controller.logOut();
                Get.offAll( const LoginScreen());
                }
              ,
              child: const Text(
                "Close Account",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Edit profile",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
