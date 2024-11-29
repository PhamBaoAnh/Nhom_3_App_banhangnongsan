import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/device/device_utility.dart';

import '../../../utils/constants/sizes.dart';

class TAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  const TAppBarBack({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Quay lại trang trước đó.
            } else {
              Get.back(); // Sử dụng GetX để quay lại nếu có thể.
            }
          },
          icon: const Icon(Iconsax.arrow_left),
        )
            : leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
