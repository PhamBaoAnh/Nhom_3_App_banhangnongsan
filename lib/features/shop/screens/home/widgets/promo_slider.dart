import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:project/features/shop/controllers/home_controller.dart';
import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banner_controller.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1.1,
            autoPlay: true, // Bật tính năng tự động di chuyển
            autoPlayInterval: const Duration(seconds: 5), // Thời gian giữa mỗi lần chuyển
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: controller.allBanners.map(
                (banner) => TRoundedImage(
              imageUrl: banner.imageUrl,
              isNetworkImage: true,
              onPressed: () {},
            ),
          ).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Center(
          child: Obx(
                () {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator(); // Hiển thị vòng xoay tải dữ liệu khi đang loading
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < controller.featuredBanners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor: controller.carousalCurrentIndex.value == i
                          ? TColors.primary
                          : TColors.grey,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
