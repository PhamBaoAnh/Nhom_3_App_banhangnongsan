import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/product_model.dart';

import '../../../features/shop/screens/productc_detail/product_detail.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../animation/animation_page_route_transition.dart';
import '../custom_search/custom_search.dart';
import '../products/product_cards/product_card_vertical.dart';


class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context); // Checks for dark mode
          return GestureDetector(
              onTap: () => Get.to(() => const SearchScreen()),
            // Use GetX for navigation
            child: Padding(
              padding: padding,
              child: Container(
                width: TDeviceUtils.getScreenWidth(context),
                padding: const EdgeInsets.all(TSizes.xm),
                decoration: BoxDecoration(
                  color: showBackground
                      ? (dark ? TColors.dark : TColors.light)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                  border: showBorder ? Border.all(color: TColors.grey) : null,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => const SearchScreen() ),
                      icon: const Icon(Icons.search_rounded),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
  }

