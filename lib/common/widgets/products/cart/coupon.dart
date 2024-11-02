import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../containers/rounded_container.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      padding: const EdgeInsets.only(top: TSizes.xsm, bottom: TSizes.xsm, right: TSizes.xsm, left: TSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(

              decoration: const InputDecoration(
                hintText: 'Nhập mã ưu đãi',
                hintStyle: TextStyle(
                  color: Colors.grey,

                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              style: const TextStyle(
                color: TColors.dark, // Màu chữ khi nhập
         /*       fontWeight: FontWeight.bold, // Kiểu chữ đậm*/
              ),
            ),
          ),

          SizedBox(
            width: 80,
            child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    foregroundColor: dark ? TColors.white.withOpacity(0.5) : TColors.white,
                    backgroundColor: TColors.primary,
                    side: BorderSide(color: TColors.primary.withOpacity(0.1))
                ),
                child: const Text('Apply')),)
        ],
      ),
    );
  }
}