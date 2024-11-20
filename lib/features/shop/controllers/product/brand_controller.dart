import 'package:get/get.dart';
import 'package:project/data/repositories/brands/BrandRepository.dart';
import 'package:project/features/shop/models/brand_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();
  final  brandRepo =Get.put(BrandRepository());

  Future<List<BrandModel>> getAllBrands() async {
      final brands =await brandRepo.getFeaturedBrands();
      return brands;

}
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