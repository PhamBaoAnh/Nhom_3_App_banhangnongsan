import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/personalization/screens/profile/widgets/profile_menu.dart';

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
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile'),),

    body: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                  const TCircularImage(image: TImages.user, isNetworkImage: false, width: 80,height: 80,),
                   TextButton(onPressed: (){}, child: const Text("Change Profile Picture")),
                  ]
                ),
              ),
              
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems ,),
              const TSectionHeading(title: 'Thông Tin Tài Khoản',showActionButton: false, textColor: TColors.black,),
              const SizedBox(height: TSizes.spaceBtwItems ,),
              
              TProfileMenu(title: 'Name', value: 'Phạm Bảo Anh', onPressed: (){},),
              TProfileMenu(title: 'UserName', value: 'Phạm Bảo Anh', onPressed: (){},),

              const SizedBox(height: TSizes.spaceBtwItems ,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems ,),

              const TSectionHeading(title: 'Thông Tin Cá Nhân',showActionButton: false, textColor: TColors.black,),
              const SizedBox(height: TSizes.spaceBtwItems ,),

              TProfileMenu(title: 'User ID', value: 'Phạm Bảo Anh',icon: Iconsax.copy, onPressed: (){},),
              TProfileMenu(title: 'Email', value: 'BioLife@gmail.com', onPressed: (){},),
              TProfileMenu(title: 'Phone Number', value: '0123456789', onPressed: (){},),
              TProfileMenu(title: 'Gender', value: 'Male', onPressed: (){},),
              TProfileMenu(title: 'Date of Birth', value: '27/10/2024', onPressed: (){},),


              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems ,),
              
              Center(
                child: TextButton(
                    onPressed: (){},
                    child: const Text("CLose Account", style: TextStyle(color: Colors.red),)
                
                ),
              )

            ],
          ),

      ),

    ),



    );
  }
}

