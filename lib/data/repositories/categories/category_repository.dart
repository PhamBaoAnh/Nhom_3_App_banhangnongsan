import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/category_model.dart';


class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _collectionPath = 'Categories';

  // Static getter to access the instance of the CategoryController

  // Method to fetch all categories from Firestore
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      // Fetching data from Firestore
      final snapshot = await _firestore.collection(_collectionPath).get();

      if (snapshot.docs.isEmpty) {
        // Handle case where there are no documents
        Get.snackbar('No Data', 'No categories found');
        return [];
      }

      final list = snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();

      // Check and print the list contents in the terminal
      print('Fetched Categories:');
      for (var category in list) {
        print('Category: ${category.name}'); // Replace 'name' with the actual field in CategoryModel
      }

      return list;

    } catch (e) {
      // Show error message if fetching categories fails
      Get.snackbar('Error', 'Error fetching categories: $e');
      return []; // Return an empty list on error
    }
  }
}
