import 'package:get/get.dart';
import 'package:project/features/shop/models/category_model.dart';
import '../../../data/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final _categoryRepository = Get.put(CategoryRepository());
 final isLoading = false.obs;
  // Initialize RxList
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    // Call fetchCategories when the controller is initialized
     fetchCategories();
  }

  // Correct async method to fetch categories
  Future<void> fetchCategories() async {
    try {
      // Fetching categories from the repository
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();

      // Update the RxList with fetched categories
      allCategories.assignAll(categories);
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      // Handle any errors that occur during fetching
      Get.snackbar('Error', 'Error fetching categories: $e');
    }
  }
}
