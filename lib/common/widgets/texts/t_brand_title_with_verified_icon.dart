import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/common/widgets/texts/t_brand_title_text.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';


class TBrandTitleWithVerifidedIcon extends StatelessWidget {
  const TBrandTitleWithVerifidedIcon({
    super.key,
    required this.title,
     this.maxLines =1 ,
    this.textColor,
    this.iconColor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSize;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TBrandTitleText(
              title: title,
              color: textColor,
              maxLines: maxLines,
              textAlign: textAlign,
              brandTextSize: brandTextSize,
            )
        ),
        const SizedBox(width: TSizes.xs),
        Icon(Iconsax.verify5, color:iconColor,size: TSizes.iconXs,)
      ],
    );
  }
}
