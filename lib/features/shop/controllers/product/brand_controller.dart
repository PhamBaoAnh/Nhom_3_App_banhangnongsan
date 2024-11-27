import 'package:get/get.dart';
import 'package:project/data/repositories/brands/BrandRepository.dart';
import 'package:project/features/shop/models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final brandRepo = Get.put(BrandRepository());
  final nameBrands =<String>[].obs;
  // RxList to hold the brand names

  // Fetch all brands
  Future<List<BrandModel>> getAllBrands() async {
    final brands = await brandRepo.getFeaturedBrands();
    return brands;
  }

  // Fetch brand names and update the reactive list
  Future<void> getNameAllBrands() async {
    final brands = await brandRepo.getFeaturedBrands();
    nameBrands.value = brands.map((brand) => brand.name).toList();
  }

  // Fetch brand by name
  Future<BrandModel?> getBrandsByName(String name) async {
    try {
      BrandModel? brand = await brandRepo.getBrandsByName(name);
      return brand;
    } catch (e) {
      Get.snackbar('Error', 'Error fetching brand: $e');
      return null;
    }
  }
}

