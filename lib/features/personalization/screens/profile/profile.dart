import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/appbar/appbar_back.dart';
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/authentication/screens/login/login.dart';

import 'package:project/features/personalization/screens/profile/widgets/profile_menu.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../shop/controllers/category_controller.dart';
import '../../../shop/controllers/home_controller.dart';
import '../../controllers/user_controller.dart';
import 'change_profile/change_profile.dart';

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

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Check if there was an error
              else if (snapshot.hasError) {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      const Text('An error occurred. Please try again later.'),
                      ElevatedButton(
                        onPressed: () {
                          controller.logOut();
                          Get.offAll(() => const LoginScreen());
                        },
                        child: const Text("Go to Login"),
                      ),
                    ]));
                //logout
              }

              // Check if we received data
              else if (snapshot.hasData) {
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
    final userController = Get.put(UserController());
    final HomeController homeController = Get.put(HomeController());
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(children: [
            Obx(() {
              final networkImage = userController.user.value.profilePicture;
              final image = (networkImage != null && networkImage.isNotEmpty)
                  ? networkImage
                  : TImages.user;
              return TCircularImage(
                image: image,
                isNetworkImage: networkImage != null && networkImage.isNotEmpty,
                width: 80,
                height: 80,
              );
            }),
            TextButton(

              onPressed: () async {
                // Chờ phương thức uploadPicture hoàn thành
                await userController.uploadPicture();

              },

               /*
              onPressed: () {
                // Gọi hàm seedProducts khi nhấn nút
                homeController.seedProducts();
              },
              */
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
          title: 'Họ & Tên',
          value: '${userdata.firstName ?? ''} ${userdata.lastName ?? ''}'.trim().isNotEmpty
              ? '${userdata.firstName} ${userdata.lastName}'
              :  'Chưa cập nhập',
          onPressed: () => Get.to(
                () => const ChangeProfileScreen(field: 'hoten'),
            transition: Transition.leftToRight, // Hiệu ứng trượt từ phải sang trái
            duration: const Duration(milliseconds: 600), // Thời gian chuyển đổi
          ),

        ),
        TProfileMenu(
          title: 'Username',
          value: userdata.username.isNotEmpty? userdata.username: 'Chưa cập nhập',
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'username',),
            transition: Transition.leftToRight, // Hiệu ứng trượt từ phải sang trái
            duration: const Duration(milliseconds: 600),),
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
          title: userdata.id,
          value: userdata.id,
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
          value: userdata.phoneNo.isNotEmpty? userdata.phoneNo: 'Chưa cập nhập',
          onPressed: ()=> Get.to(() =>   const  ChangeProfileScreen( field: 'phoneNo'),
            transition: Transition.leftToRight, // Hiệu ứng trượt từ phải sang trái
            duration: const Duration(milliseconds: 600),),
        ),
        TProfileMenu(
          title: 'Gender',
          value:userdata.gender.isNotEmpty ? userdata.gender:'Chưa cập nhập'
,
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'gender'),
            transition: Transition.leftToRight, // Hiệu ứng trượt từ phải sang trái
            duration: const Duration(milliseconds: 600),),
        ),
        TProfileMenu(
          title: 'Date of Birth',
          value: userdata.dateOfBirth.isNotEmpty? userdata.dateOfBirth:'Chưa cập nhập',
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'dateOfBirth'),
            transition: Transition.leftToRight, // Hiệu ứng trượt từ phải sang trái
            duration: const Duration(milliseconds: 600),),
        ),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary),
            ),
            onPressed: ()  {
              controller.deleteUser(userdata);
            },
            child: const Text(
              'Xóa Tài khoản',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
