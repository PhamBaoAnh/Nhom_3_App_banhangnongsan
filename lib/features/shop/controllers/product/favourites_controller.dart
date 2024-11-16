import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:project/utils/local_storage/storage_utility.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites(); // Initialize favorites from local storage
  }

  Future<void> initFavorites() async {
    try {
      // Read favorites from local storage
      final json = TLocalStorage.instance().readData<String>('favorites');
      if (json != null && json.isNotEmpty) {
        final storageFavorites = jsonDecode(json) as Map<String, dynamic>;

        // Safely assign parsed values to the favorites observable
        favorites.assignAll(
          storageFavorites.map((key, value) => MapEntry(key, value == true)),
        );
      }
    } catch (e) {
      // Log error or handle accordingly
      print('Error loading favorites: $e');
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId) || !favorites[productId]!) {
      favorites[productId] = true; // Mark as favorite
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Sản phẩm đã được thêm vào mục yêu thích');
    } else {

      favorites.remove(productId); // Remove from favorites
      saveFavoritesToStorage();
      TLoaders.customToast(message: 'Sản phẩm đã được xóa khỏi mục yêu thích');
    }
  }



  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    // Fetch favorite products from the repository
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
