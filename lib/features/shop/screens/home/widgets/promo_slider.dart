import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../../common/widgets/animation/animation_page_route_transition.dart';
import '../../../../../common/widgets/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart'; // Thư viện chứa TRoundedImage
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/navigation_menu.dart';
import '../../../controllers/banner_controller.dart';
import '../../store/store.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.allBanners.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.1,
              autoPlay: true, // Tự động chuyển slide
              autoPlayInterval: const Duration(seconds: 5), // Khoảng thời gian giữa các slide
              onPageChanged: (index, _) {
                if (index >= 0 && index < controller.featuredBanners.length) {
                  controller.updatePageIndicator(index);
                }
              },
            ),
            items: controller.allBanners.map(
                  (banner) {
                return TRoundedImage(
                  imageUrl: banner.imageUrl,
                  isNetworkImage: true, // Xác định ảnh tải từ mạng
                  onPressed: () async {
                    final NavigationController navigationController = Get.find<NavigationController>();

                    // Đảm bảo cập nhật giá trị được thực hiện trước khi chuyển trang
                    navigationController.selectedIndex.value = 1;

                    // Thực hiện chuyển trang với transition mượt mà
                    await Future.delayed(const Duration(milliseconds: 100));  // Có thể thêm delay nhỏ để giảm độ giật
                    Get.to(() => const NavigationMenu(), transition: Transition.leftToRight);
                  },

                  borderRadius: 12, // Tùy chỉnh bán kính góc bo
                );
              },
            ).toList(),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                controller.featuredBanners.length,
                    (index) => TCircularContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor: controller.carousalCurrentIndex.value == index
                      ? TColors.primary
                      : TColors.grey,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
