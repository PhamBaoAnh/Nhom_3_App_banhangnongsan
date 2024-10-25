import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.user,
        isNetworkImage: false,
        width:50, height:50, padding: 0, // Áp dụng màu phủ
      ),

      title: Text('Phạm Bảo Anh', style:Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text('biolife@gmail.com', style:Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed: (){}, icon: const Icon(Iconsax.edit, color: TColors.white,)),

    );
  }
}
