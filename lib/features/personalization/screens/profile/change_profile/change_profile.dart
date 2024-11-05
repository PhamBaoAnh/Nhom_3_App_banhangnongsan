import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart';
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart';
import 'package:project/features/authentication/models/user_model.dart';
import 'package:project/features/personalization/screens/profile/profile.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:project/repository/user_repo/user_repo.dart';

import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../authentication/screens/login/widgets/login_form.dart';
import '../../../../authentication/screens/login/widgets/login_header.dart';

class ChangeProfileScreen extends StatelessWidget {
  final String field;
  const ChangeProfileScreen({super.key, required this.field});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Thay đổi thông tin'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: FutureBuilder<dynamic>(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No user data available.'));
                    }
                    UserModel userdata = snapshot.data!;
                    controller.firstName.text =userdata.firstName;
                    controller.lastName.text =userdata.lastName;
                    controller.username.text= userdata.username;
                    controller.phoneNo.text =userdata.phoneNo;
                    if(field == 'hoten'){  return Column(
                      children: [
                        Text(TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TextFormField(
                          controller: controller.firstName,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: TTexts.firstName,
                          ),
                        ),
                        const SizedBox(
                            height: TSizes.spaceBtwInputFields * 1.5),
                        TextFormField(
                          controller: controller.lastName,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: TTexts.lastName,
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserModel userChange = userdata.copyWith({
                                'firstName': controller.firstName.text,
                                'lastName': controller.lastName.text,
                              });
                              await userRepo.instance.updateUser(userChange);
                              Get.offAll(const ProfileScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                side: const BorderSide(color: TColors.primary)),
                            child: const Text(TTexts.changeProfileName),
                          ),
                        ),
                      ],
                    );}
                    else if(field =='username') {return Column(
                      children: [
                        Text(TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TextFormField(
                          controller: controller.username,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: TTexts.username,
                          ),
                        ),
                        const SizedBox(
                            height: TSizes.spaceBtwInputFields * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserModel userChange = userdata.copyWith({
                                'username': controller.username.text,
                              });
                              // UserModel(id: userdata.id, gender: userdata.gender, firstName: updateController.firstName.text, lastName: updateController.lastName.text, username: userdata.username, email: userdata.email, password: userdata.password, phoneNo: userdata.phoneNo, dateOfBirth: userdata.dateOfBirth);
                              await userRepo.instance.updateUser(userChange);
                              Get.offAll(const ProfileScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                side: const BorderSide(color: TColors.primary)),
                            child: const Text(TTexts.changeProfileName),
                          ),
                        ),
                      ],
                    ); }
                    else if(field =='phoneNo'){return Column(
                      children: [
                        Text(TTexts.loginSubTitle,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Form(
                          key: formKey,
                          child: TextFormField(
                            controller: controller.phoneNo,
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
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: TTexts.phoneNo,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: TSizes.spaceBtwInputFields * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                UserModel userChange = userdata.copyWith({
                                  'phoneNo': controller.phoneNo.text,
                                });
                                await userRepo.instance.updateUser(userChange);
                                Get.offAll(const ProfileScreen());
                              };
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                side: const BorderSide(color: TColors.primary)),
                            child: const Text(TTexts.changeProfileName),
                          ),
                        ),
                      ],
                    ); }
                    else if(field =='gender'){return Column(
                      children: [
                        Text(TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TextFormField(
                          controller: controller.gender,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'Gender',
                          ),
                        ),
                        const SizedBox(
                            height: TSizes.spaceBtwInputFields * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserModel userChange = userdata.copyWith({
                                'gender': controller.gender.text,
                              });
                              await userRepo.instance.updateUser(userChange);
                              Get.offAll(const ProfileScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                side: const BorderSide(color: TColors.primary)),
                            child: const Text(TTexts.changeProfileName),
                          ),
                        ),
                      ],
                    );}
                    else if(field =='dateOfBirth'){return Column(
                      children: [
                        Text(TTexts.loginSubTitle,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        TextFormField(
                          controller: controller.dateOrBirth,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.user),
                            labelText: 'Date of birth',
                          ),
                        ),
                        const SizedBox(
                            height: TSizes.spaceBtwInputFields * 1.5),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserModel userChange = userdata.copyWith({
                                'dateOfBirth': controller.dateOrBirth.text,
                              });

                              await userRepo.instance.updateUser(userChange);
                              Get.offAll(const ProfileScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                side: const BorderSide(color: TColors.primary)),
                            child: const Text(TTexts.changeProfileName),
                          ),
                        ),
                      ],
                    );}
                    return SizedBox.shrink();
                  }))),
    );
  }
}
