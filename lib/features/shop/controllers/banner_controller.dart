import 'dart:async';
import 'package:get/get.dart';
import '../../../data/repositories/banners/banner_repository.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final isLoading = false.obs;
  final _bannerRepository = Get.put(BannerRepository());

  final carousalCurrentIndex = 0.obs;
  RxList<BannerModel> allBanners = <BannerModel>[].obs;
  RxList<BannerModel> featuredBanners = <BannerModel>[].obs;

  Timer? _carouselTimer;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
    startAutoCarousel();
  }

  @override
  void onClose() {
    _carouselTimer?.cancel();
    super.onClose();
  }

  void updatePageIndicator(int index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final banners = await _bannerRepository.getAllBanners();
      allBanners.assignAll(banners);
      featuredBanners.assignAll(
        allBanners.where((banner) => banner.active).take(3).toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void startAutoCarousel() {
    // Tạo một timer để tự động thay đổi `carousalCurrentIndex` sau mỗi 3 giây
    _carouselTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (featuredBanners.isNotEmpty) {
        carousalCurrentIndex.value =
            (carousalCurrentIndex.value + 1) % featuredBanners.length;
      }
    });
  }
}
