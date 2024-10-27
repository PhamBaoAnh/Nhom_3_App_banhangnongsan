import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/images/t_circular_image.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/containers/primary_header_container.dart';
import '../../../../common/widgets/list_titles/settings_menu_title.dart';
import '../../../../common/widgets/list_titles/user_profile_title.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          TPrimaryHeaderContainer(
            child: Column(
              children: [
                 TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),),),


                  const TUserProfileTitle(),
                  const SizedBox(height: TSizes.spaceBtwSections,),
              ],
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(title: 'Account Settings', textColor: TColors.black,showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  TSettingsMenuTitle(icon: Iconsax.safe_home, title: 'My Address', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.safe_home, title: 'Account Privacy', subTitle: 'Set shopping delivery address', onTap: (){},),

                  const SizedBox(height: TSizes.spaceBtwSections,),
                  const TSectionHeading(title: 'App Settings', textColor: TColors.black,showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  TSettingsMenuTitle(icon: Iconsax.document_cloud, title: 'Load data', subTitle: 'Set shopping delivery address', onTap: (){},),
                  TSettingsMenuTitle(icon: Iconsax.location, title: 'Geolocations', subTitle: 'Set shopping delivery address', trailing: Switch(value:true, onChanged: (value) {})),
                  TSettingsMenuTitle(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Set shopping delivery address', trailing: Switch(value:false, onChanged: (value) {})),
                  TSettingsMenuTitle(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set shopping delivery address', trailing: Switch(value:false, onChanged: (value) {})),

                  const SizedBox(height: TSizes.spaceBtwSections,),
                   SizedBox(
                     width: double.infinity,
                     child: OutlinedButton(onPressed: (){}, child: const Text('Đăng Xuất' )),
                   ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2,),


                ],
              ),

          )


          ],
        ),
      ),
    );
  }
}

